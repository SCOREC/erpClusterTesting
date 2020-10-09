perftest ib_atomic_lat and ib_read_bw run between a pair of cluster nodes
(erp[11,12]) vs a pair of himem nodes (erp[13,14]). Each test run for 100000
iterations, two attempts of each test. Locked to NUMA node closest to IB
adapter, ex:

```
erp13# numactl -N 4 ib_atomic_lat

erp14# numactl -N 4 ib_atomic_lat -n 100000 erp13
```
