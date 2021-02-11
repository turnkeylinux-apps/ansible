Ansible® - Radically simple IT automation platform
==================================================

`Ansible`_ is a simple, agentless IT automation engine that automates
cloud provisioning, configuration management, application deployment and
intra-service orchestration. It can configure systems, deploy software,
and streamline advanced IT tasks such as continuous deployments or zero
downtime rolling updates.

This appliance includes all the standard features in `TurnKey Core`_, and on top of that:

- Stable release of Ansible installed via pip.
- WinRM support for managing Windows hosts.
- Sudo support for the ansible user.
- SSL support out of the box.
- Webmin modules for managing and configuring server.

Usage
-----

For examples of how to use the Ansible appliance, see `Usage`_.

Resources
---------

- `Latest official Ansible documentation <https://docs.ansible.com/ansible/index.html>`_
- `Ansible on GitHub <https://github.com/ansible>`_
- `Configuration management with Ansible <http://jpmens.net/2012/06/06/configuration-management-with-ansible/>`_
- `Ansible playbooks for use in setting up servers <https://github.com/fourkitchens/server-playbooks>`_

Ansible® is a registered trademark of Ansible, Inc. in the United States and other countries.

Note: This software appliance is not supported by Ansible or Red Hat

Credentials *(passwords set at first boot)*
-------------------------------------------

-  Webmin, SSH: username **root**
-  Ansible: username **ansible**  

.. _Usage: https://github.com/turnkeylinux-apps/ansible/blob/master/docs/usage.rst
.. _Ansible: https://docs.ansible.com/ansible/index.html
.. _TurnKey Core: https://www.turnkeylinux.org/core
