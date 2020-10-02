# OpenMPI 4.0.1 #

Spack spec:

`openmpi@4.0.1~cuda+cxx_exceptions fabrics=ucx ~java~legacylaunchers~memchecker+pmi schedulers=slurm ~sqlite3~thread_multiple+vt`

`ucx` 1.5.2 is installed via spack.

## NUMA Binding ##

Processes are bound to cores in order of increasing distance from the NUMA
domain associated with the InfiniBand interface.  `hwloc-ls` was used to determine the layout of NUMA domains as described in the [AMD EPYC Cluster Tuning](http://developer.amd.com/wp-content/resources/56420.pdf) doc.  The slurm argument to specify the binding is set in [runOpenMPI.sh](https://github.com/SCOREC/erpClusterTesting/blob/b60a9073530502a9a8e44dda478b177c4a3fbf12/mpiAllReduce/runOpenMPI.sh#L10-L19).


![numappn12](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_ppn12procSweep.png?raw=true)
![numappn24](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_ppn24procSweep.png?raw=true)
![numappn48](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_ppn48procSweep.png?raw=true)
![numap96](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_p96ppnSweep.png?raw=true)

## Default Binding ##

![defaultppn12](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_ppn12procSweep.png?raw=true)
![defaultppn24](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_ppn24procSweep.png?raw=true)
![defaultppn48](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_ppn48procSweep.png?raw=true)
![defaultp96](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_p96ppnSweep.png?raw=true)

## mpirun, core binding, verbs, no ucx##

The ib interface was enabled by creating the following file:

```
$ cat ~/.openmpi/mca-params.conf
btl_openib_allow_ib = 1
```

It was not clear how to pass this option through srun.

OpenMPI 4.0.1 was built with the following configure script:

```
./configure --with-slurm --with-pmi=/usr --without-ucx --prefix=/gpfs/u//software/erp-rhel7/openmpi/4.0.1/2/
```

with the following environment settings on erp13:

```
module use /gpfs/u/software/erp-spack-install/lmod/linux-centos7-x86_64/Core/
module load gcc/7.4.0-vuvgy2j
```

The osu benchmarks 5.6.1 were built with the same environment, the openmpi install dir added to PATH, and the following configure command:

```
./configure CC=mpicc CXX=mpicxx --prefix=/gpfs/u/home/CCNI/CCNIsmth/barn-shared/CWS/osu-micro-benchmarks-5.6.1-erp-openmpi.4.0.1-verbs-noUcx-Pmi-install
```

Plots generated from the `slurm-*.out` files are generated with:

```
python /path/to/erpClusterTesting/mpiAllReduce/plot.py
```

![ppn12](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/openmpi4verbsNoUcxMpirun/ppn12.png?raw=true)
![ppn24](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/openmpi4verbsNoUcxMpirun/ppn24.png?raw=true)
![ppn48](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/openmpi4verbsNoUcxMpirun/ppn48.png?raw=true)
