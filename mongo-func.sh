function mongo() {
  if [ -e ~/.mongo.cnf ]; then
    . ~/.mongo.cnf
  else
    echo "Please run mongo_add_creds.sh to create a ~/.mongo.cnf file";
    return
  fi

  mongoprof=$1
  shift

  if [ -z "$mongoprof" ]; then
    PS3='Select MongoDB profile: '
    select mongoprof in $(sed -e 's/^.*\[\(.*\)\].*$/\1/' -e '/^$/d' ~/.mongo.cnf | uniq | tail -n+2); do
      if [[ -n $mongoprof ]]; then
        break
      else
        echo 'Invalid selection'
      fi
    done
  fi

  /usr/bin/mongo --host ${mongosetid[$mongoprof]}/${mongohost[$mongoprof]}:${mongoport[$mongoprof]} --username ${mongouser[$mongoprof]} --password ${mongopass[$mongoprof]} admin "$@"
}
