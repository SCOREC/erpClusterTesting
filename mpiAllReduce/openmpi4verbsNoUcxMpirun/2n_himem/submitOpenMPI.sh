#!/bin/bash
[ $# -ne 4 ] && echo "Usage: $0 <num_processes> <ppn> <numabinding=[on|off]> <coreRequest=[on|off]>" && exit 1
p=$1
ppn=$2
binding=$3
coreReq=$4
nodes=$((p/ppn))
coreReqArg=""
[ "$coreReq" == "on" ] && coreReqArg="--mincpus=48"
echo "coreReqArg $coreReqArg"
set -x
sbatch -d singleton -p himem -t 10 -N $nodes -n $p $coreReqArg ./mpirunOpenMPI.sh $p $binding
set +x
