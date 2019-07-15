#!/bin/bash 
#SBATCH -J erpMpiTesting
p=$1
numabind=$2
module use /gpfs/u/software/erp-spack-install/lmod/linux-centos7-x86_64/Core/
module load gcc
export PATH=$PATH:/gpfs/u/barn/CCNI/shared/CWS/openmpi-4.0.1/install-noVerbs-pmi-gcc7.4.0/bin
bin=/gpfs/u/home/CCNI/CCNIsmth/barn-shared/CWS/osu-micro-benchmarks-5.6.1-erp-openmpi.4.0.1ucxNoVerbsPmi-install/libexec/osu-micro-benchmarks/mpi/
numamap=""
#populate socket 1 then socket 0
for nn in 4 5 6 7 0 1 2 3; do
  for core in {1..6}; do # six cores per numa domain
    if [ -z "$numamap" ]; then
      numamap=${nn}
    else
      numamap=${numamap},${nn}
    fi
  done
done
binding="default"
[ "$numabind" == "on" ] && bindopt=",map_ldom=${numamap}" && binding="numa"
echo "processes $p"
echo "nodes $SLURM_JOB_NUM_NODES"
echo "ppn $((p/SLURM_JOB_NUM_NODES))"
echo "binding ${binding}"
set -x
srun --mpi=pmi2 -n $p --cpu_bind=verbose${bindopt} $bin/collective/osu_allreduce
set +x
