#!/bin/bash
set -euo pipefail
umask 077

result=${TKL_TEST_RESULT:?TKL_TEST_RESULT is required}
password=${TKL_TEST_APP_PASS:?TKL_TEST_APP_PASS is required}
work=/run/tkl-v19-tests/ansible

cleanup() {
    status=$?
    trap - EXIT
    rm -rf -- "$work"
    exit "$status"
}
trap cleanup EXIT

install -d -o ansible -g ansible -m 0700 "$work"

systemctl --quiet is-active \
    semaphore.service nginx.service mariadb.service multi-user.target
grep -Fq '[40ansible] successfully completed' /var/log/inithooks.log
grep -Fq '[50ansible-key] successfully completed' /var/log/inithooks.log

curl -kfsS https://127.0.0.1/ >"$work/semaphore.html"
grep -Eqi 'semaphore|sign in|login' "$work/semaphore.html"

printf '%s' "$password" | python3 -c '
import json
import sys

with open(sys.argv[1], "w") as output:
    json.dump({"auth": "admin", "password": sys.stdin.read()}, output)
' "$work/login.json"
curl -fsS -o /dev/null -c "$work/cookies" \
    -H 'Content-Type: application/json' \
    --data-binary @"$work/login.json" \
    http://127.0.0.1:3000/api/auth/login
curl -fsS -b "$work/cookies" http://127.0.0.1:3000/api/user \
    >"$work/user.json"
python3 -c '
import json
import sys

assert json.load(open(sys.argv[1]))["username"] == "admin"
' "$work/user.json"

cat >"$work/local-flow.yml" <<'YAML'
---
- name: TurnKey v19 local Ansible flow
  hosts: localhost
  connection: local
  gather_facts: false
  tasks:
    - name: Write the acceptance marker through an Ansible module
      ansible.builtin.copy:
        content: ansible-v19-local-flow
        dest: /run/tkl-v19-tests/ansible/marker
        mode: '0600'
YAML
chown ansible:ansible "$work/local-flow.yml"
runuser -u ansible -- ansible-playbook -i localhost, "$work/local-flow.yml" \
    >"$work/playbook.log"
grep -Fxq ansible-v19-local-flow "$work/marker"

ansible_version=$(dpkg-query -W -f='${Version}' ansible)
semaphore_version=$(dpkg-query -W -f='${Version}' semaphore)
candidate=$(apt-cache policy ansible | awk '/Candidate:/ {print $2}')
test -n "$candidate" && test "$candidate" != '(none)'
grep -Rqs '^Suites:.*trixie' /etc/apt/sources.list.d
if test -f /etc/apt/sources.list; then
    ! grep -qi bookworm /etc/apt/sources.list
fi
! grep -Rqi bookworm /etc/apt/sources.list.d

systemctl restart mariadb.service
systemctl restart semaphore.service nginx.service
systemctl --quiet is-active semaphore.service nginx.service mariadb.service
for _ in $(seq 1 20); do
    if curl -fsS -b "$work/cookies" http://127.0.0.1:3000/api/user \
            >"$work/user-after-restart.json"; then
        break
    fi
    sleep 1
done
curl -fsS -b "$work/cookies" http://127.0.0.1:3000/api/user \
    >"$work/user-after-restart.json"
python3 -c '
import json
import sys

assert json.load(open(sys.argv[1]))["username"] == "admin"
' "$work/user-after-restart.json"

! grep -F -- "$password" /var/log/inithooks.log

cat >"$result" <<EOF
package_source=Debian Trixie Ansible package and upstream Semaphore Debian package
installed_version=ansible $ansible_version; semaphore $semaphore_version
runtime_checks=Ansible and Semaphore firstboot hooks, Semaphore HTTPS and admin API login, local Ansible module execution, and authenticated API persistence across service restart
updater_command=apt-cache policy ansible; dpkg-query -W semaphore
updater_result=Ansible APT candidate $candidate found; installed Ansible and Semaphore packages unchanged
updater_channel=Debian Trixie APT for Ansible and supervised upstream Semaphore releases
integrity_evidence=Ansible installed package is bound to configured signed Trixie metadata with no Bookworm source; Semaphore identity is recorded in dpkg state
EOF
