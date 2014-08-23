mongo-cli-wrapper
=================

Wraps mongo command in a wrapper that reads the profile from a file, much like MySQL's .my.cnf. This version assumes you are connecting to a replica set.

Requires jq (http://stedolan.github.io/jq/) to be in your path.

Uses two files:

* mongo-func.sh: Source this in your login script or add it to /etc/profile.d/ to make available to all users.
* mongo_add_creds.sh: Add this somewhere your path will pick it up, such as /usr/local/bin/
