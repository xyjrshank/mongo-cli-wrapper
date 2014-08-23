#!/bin/bash

set -e

cfgfile=~/.mongo.cnf

fqdn=$1
if [ -z "$fqdn" ]; then
  read -p "FQDN of MongoDB node: " fqdn;
fi

port=$2
if [ -z "$port" ]; then
  read -p "Port of MongoDB node: " fqdn;
fi

username=$3
if [ -z "$username" ]; then
  read -p "Your MongoDB username: " username;
fi

password=$4
if [ -z "$password" ]; then
  read -s -p "Your MongoDB password: " password;
  echo
fi

hostname=$(echo $fqdn | awk -F'.' '{ print $1 }')
shortname=$(echo "${hostname%?}" | sed 's/-/_/g')
setid=$(echo 'rs.conf()' | /usr/bin/mongo --quiet admin --host $fqdn:$port -u $username -p $password | jq -r '._id')

if [ ! -e $cfgfile ]; then
  echo 'declare -A mongohost mongoport mongouser mongopass mongosetid' > $cfgfile
fi

cat << EOF >> $cfgfile

mongohost[$shortname]=$fqdn
mongoport[$shortname]=$port
mongouser[$shortname]=$username
mongopass[$shortname]=$password
mongosetid[$shortname]=$setid
EOF

chmod 0600 $cfgfile

echo "Credentials added to $cfgfile"
