#!/bin/bash
[ $# -ne 2 ] && echo "Usage: $0 <numabinding=[on|off]> <coreRequest=[on|off]>" && exit 1
binding=$1
coreReq=$2
for ppn in 12 24 48; do
  for nodes in 2 4 6 8 10 12; do # 8 12; do
    p=$((ppn*nodes))
    echo $ppn $nodes $((p))
    set -x
    ./submitOpenMPI.sh $p $ppn $binding $coreReq
    set +x
  done
done
