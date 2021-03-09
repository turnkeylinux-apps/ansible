#!/usr/bin/python3

'''
---
module: turnkey_facts
short_description: Gathers facts from TurnKey GNU/Linux Appliances
description:
    - Runs 'turnkey-version'
    - Returns:
        - turnkey                = True if successful
        - turnkey_app            = TurnKey Appliance application eg. wordpress
        - turnkey_ver            = TurnKey GNU/Linux version eg. 16.0
        - turnkey_arch           = Linux target architecture
        - turnkey_deb            = Codename for Debian version eg. buster
        - turnkey_version_output = Output from turnkey-version
'''

import sysversion  # turnkey-version lib
from ansible.module_utils.basic import *

# Not sure if DOCUMENTATION var is needed? I don't know enough about ansible...
DOCUMENTATION = __doc__


def main():
    result = {'ansible_facts': {}}
    global module
    module = AnsibleModule(argument_spec=dict(), supports_check_mode=True)

    turnkey_version = sysversion.get_turnkey_version('/',
                                                     'etc/turnkey_version')
    if turnkey_version:
        tkl_appver_cls = sysversion.AppVer(turnkey_version, rootfs='/')

        result['ansible_facts']['turnkey'] = True
        result['ansible_facts']['turnkey_version_output'] = turnkey_version
        result['ansible_facts']['turnkey_app'] = tkl_appver_cls.appname
        result['ansible_facts']['turnkey_ver'] = tkl_appver_cls.tklver
        result['ansible_facts']['turnkey_arch'] = tkl_appver_cls.arch
        result['ansible_facts']['turnkey_deb'] = tkl_appver_cls.codename
    else:
        result['ansible_facts']['turnkey'] = False

    module.exit_json(**result)


if __name__ == '__main__':
    main()
