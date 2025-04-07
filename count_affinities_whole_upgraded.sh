#!/bin/bash

# upgraded to add command line directory entry from ChatGPT
# to use:
# $ sudo bash count_affinities_whole.sh directory

# set appropriate path
LOG_PATH=$1

# Check if the directory exists
if [ ! -d "$LOG_PATH" ]; then
  echo "Error: Directory does not exist"
  exit 1
fi

# from 0 to 9
i=0
until [ $i -gt 9 ]
do
  echo "Count for -$i.0"
  grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[$i]. -m 1 ${LOG_PATH}//*.txt | wc -l
  echo ...
  ((i=i+1))
done

# from 10 to 12
i=0
until [ $i -gt 5 ]
do
  echo "Count for -1$i.0"
  grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[0-9][$i]. -m 1 ${LOG_PATH}//*.txt | wc -l
  echo ...
  ((i=i+1))
done
