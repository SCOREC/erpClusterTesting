#!/bin/bash
first=1
for i in *.out; do
  echo $i
  grep '^[0-9]\|processes\|nodes\|ppn' $i | \
    tr -s ' ' | \
    tr ' ' ',' > /tmp/$i.csv
  if [ $first ]; then
    cut -d"," -f1 /tmp/$i.csv > labels
    first=0
  fi
  cut -d"," -f2- /tmp/$i.csv > $i.dat
done
paste -d , labels *.dat > runs.csv
