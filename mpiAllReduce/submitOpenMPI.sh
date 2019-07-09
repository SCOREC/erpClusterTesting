#!/bin/bash
[ $# -ne 3 ] && echo "Usage: $0 <num_processes> <ppn> <numabinding=[on|off]>" && exit 1
p=$1
ppn=$2
binding=$3
nodes=$((p/ppn))
set -x
sbatch -d singleton -p erp -t 30 -N $nodes -n $((nodes*48)) ./runOpenMPI.sh $p $binding
set +x
