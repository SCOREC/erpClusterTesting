from os import listdir
from os.path import isfile, join
import pandas as pd
import matplotlib.pyplot as plt

dir="./"
slurmLogs = [f for f in listdir(dir) if isfile(join(dir, f)) and f.endswith('out')]
print(slurmLogs)

messageSz=[]
with open(slurmLogs[0]) as f:
    read_data = f.readlines()
for line in read_data:
    if line[0].isdigit():
        sz = int(line.split()[0])
        messageSz.append(sz)
print('msgSz',messageSz)

#dict of ppn to dict of processes to list of latency
ppn2procs2latency={12:{},24:{},48:{}}
for log in slurmLogs:
    with open(log) as f:
        read_data = f.readlines()
    procs=0
    ppn=0
    latency=[]
    for line in read_data:
        if line.startswith('processes'):
            procs = int(line.split()[1])
            print('procs', procs)
        elif line.startswith('ppn'):
            ppn = int(line.split()[1])
            print(ppn)
        elif line[0].isdigit():
            t = float(line.split()[1])
            latency.append(t)
    ppn2procs2latency[ppn][procs] = latency

for ppn in [12, 24, 48]:
    zeros = [0]*len(messageSz)
    for procs,vals in ppn2procs2latency[ppn].items():
        if len(vals) != len(messageSz):
            print("Warning: ppn " + str(ppn) + " procs " + str(procs) + \
                    " is missing vals, setting the results to zero")
            ppn2procs2latency[ppn][procs] = zeros
    df = pd.DataFrame.from_dict(ppn2procs2latency[ppn])
    df['msgSz'] = messageSz
    title='ERP allreduce average latency core binding ppn ' + str(ppn) \
            + ':\nsweep over process count'
    ax = df.plot(x='msgSz',title=title,logx=True)
    ax.set_ylabel('average latency (us)')
    ax.set_xlabel('message size (B)')
    fig = ax.get_figure()
    fig.savefig('ppn' + str(ppn) + '.png')
