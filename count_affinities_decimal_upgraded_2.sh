#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <log directory>"
  exit 1
fi

# set appropriate path
LOG_PATH=$1

# Check if the directory exists
if [ ! -d "$LOG_PATH" ]; then
  echo "Error: Directory does not exist"
  exit 1
fi

# make output file
> ${LOG_PATH}/affinity_counts.txt
echo "# Affinity is followed by count" >> ${LOG_PATH}/affinity_counts.txt
echo >> ${LOG_PATH}/affinity_counts.txt

# find all .txt files recursively under LOG_PATH
files=$(find ${LOG_PATH} -name "*.txt")

# from 0 to 9
i=0
until [ $i -gt 9 ]
do
  echo "Starting count for -$i"
  h=0
  until [ $h -gt 9 ]
  do
    echo "-$i.$h" >> ${LOG_PATH}/affinity_counts.txt
    echo "$files" | xargs grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[$i].[$h] -m 1 | wc -l \
    >> ${LOG_PATH}/affinity_counts.txt
    echo ...
    ((h=h+1))
  done
  ((i=i+1))
done

# from 10 to 19
i=0
until [ $i -gt 9 ]
do
  echo "Starting count for -1$i"
  h=0
  until [ $h -gt 9 ]
  do
    echo "-1$i.$h" >> ${LOG_PATH}/affinity_counts.txt
    echo "$files" | xargs grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[0-9][$i].[$h] -m 1 | wc -l \
    >> ${LOG_PATH}/affinity_counts.txt
    echo ...
    ((h=h+1))
  done
  ((i=i+1))
done

# from 20 to 29
i=0
until [ $i -gt 9 ]
do
  echo "Starting count for -2$i"
  h=0
  until [ $h -gt 9 ]
  do
    echo "-2$i.$h" >> ${LOG_PATH}/affinity_counts.txt
    echo "$files" | xargs grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[0-9][$i].[$h] -m 1 | wc -l \
    >> ${LOG_PATH}/affinity_counts.txt
    echo ...
    ((h=h+1))
  done
  ((i=i+1))
done
echo " "
echo "Completed. Results saved to affinity_counts.txt in $LOG_PATH"
