# OpenMPI 4.0.1 #

Spack spec:

`openmpi@4.0.1~cuda+cxx_exceptions fabrics=ucx ~java~legacylaunchers~memchecker+pmi schedulers=slurm ~sqlite3~thread_multiple+vt`

`ucx` 1.5.2 is installed via spack.

## NUMA Binding ##

Processes are bound to cores in order of increasing distance from the NUMA
domain associated with the InfiniBand interface.

![numappn12](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_ppn12procSweep.png?raw=true)
![numappn24](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_ppn24procSweep.png?raw=true)
![numappn48](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_ppn48procSweep.png?raw=true)
![numap96](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/numaBinding/numa_p96ppnSweep.png?raw=true)

## Default Binding ##

![defaultppn12](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_ppn12procSweep.png?raw=true)
![defaultppn24](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_ppn24procSweep.png?raw=true)
![defaultppn48](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_ppn48procSweep.png?raw=true)
![defaultp96](https://github.com/SCOREC/erpClusterTesting/blob/master/mpiAllReduce/defaultBinding/default_p96ppnSweep.png?raw=true)
