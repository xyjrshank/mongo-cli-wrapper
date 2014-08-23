mongo-cli-wrapper
=================

Wraps mongo command in a wrapper that reads the profile from a file, much like MySQL's .my.cnf.

Uses two files:

* mongo-func.sh: Source this in your login script or add it to /etc/profile.d/ to make available to all users.
* mongo_add_creds.sh: Add this somewhere your path will pick it up, such as /usr/local/bin/
