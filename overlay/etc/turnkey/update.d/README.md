/etc/turnkey/update.d
=====================

Executable scripts placed in this directory will be run by turnkey-update
when options "--update" or "--dist-upgrade" are specified.

Update scripts must be idempotent, that is multiple executions achieve the
exact same result.  Ideally each script will check to see if the desired
changes have already been made and if so, will do nothing.

Wikipedia
---------

Idempotence: "the property of certain operations in mathematics and computer
science, that can be applied multiple times without changing the result beyond
the initial application."
