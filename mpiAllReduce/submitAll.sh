#!/bin/bash
[ $# -ne 1 ] && echo "Usage: $0 <numabinding=[on|off]>" && exit 1
binding=$1
for ppn in 12 24 48; do
  for nodes in 2 4 8 12; do
    p=$((ppn*nodes))
    echo $ppn $nodes $((p))
    set -x
    ./submitOpenMPI.sh $p $ppn $binding
    set +x
  done
done
