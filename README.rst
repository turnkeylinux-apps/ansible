Ansible® - Radically simple IT automation platform
==================================================

`Ansible`_ is a simple, agentless IT automation engine that automates
cloud provisioning, configuration management, application deployment and
intra-service orchestration. It can configure systems, deploy software,
and streamline advanced IT tasks such as continuous deployments or zero
downtime rolling updates.

This appliance includes all the standard features in `TurnKey Core`_, and on
top of that:

   - Stable release of Ansible installed via pip.
   - WinRM support for managing Windows hosts.
   - Sudo support for the ansible user.
   - Semaphore_ open source web UI for Ansible.
   - SSL support out of the box.
   - Webmin modules for managing and configuring server.

Usage
-----

For examples of how to use the Ansible appliance, see `Usage`_.

Resources
---------

   - `Official Ansible docs`_.
   - `Ansible on GitHub`_.
   - `Configuration management with Ansible`_ (old but still useful overview
     and "getting started" info).
   - `Ansible Galaxy`_ Community provided "playbooks".
   - `Semaphore "First steps"`_ and `screenshots`_
   - `Semaphore UI Walkthrough`_

Ansible® is a registered trademark of Ansible, Inc. in the United States and other countries.

Note: This software appliance is not supported by Ansible or Red Hat

Credentials *(passwords set at first boot)*
-------------------------------------------

-  Webmin, SSH: username **root**
-  Ansible: username **ansible**  

.. _Ansible: https://docs.ansible.com/ansible/index.html
.. _TurnKey Core: https://www.turnkeylinux.org/core
.. _Semaphore: https://ansible-semaphore.com/
.. _Usage: https://github.com/turnkeylinux-apps/ansible/blob/master/docs/usage.rst
.. _Official Ansible docs: https://docs.ansible.com/ansible/latest/user_guide/index.html
.. _Ansible on GitHub: https://github.com/ansible
.. _Configuration management with Ansible: https://jpmens.net/2012/06/06/configuration-management-with-ansible/
.. _Ansible Galaxy: https://galaxy.ansible.com/
.. _Semaphore "First steps": https://github.com/ansible-semaphore/semaphore/wiki/First-Steps
.. _screenshots: https://github.com/ansible-semaphore/semaphore/wiki/Screenshots
.. _Semaphore UI Walkthrough: https://blog.strangeman.info/ansible/2017/08/05/semaphore-ui-guide.html
