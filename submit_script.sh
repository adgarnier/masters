#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <directory name> <# jobscripts>"
  exit 1
fi

name=$1
number=$2

i=1
until [ $i -gt $number ]
do
  sbatch vina_top0005_jobscript_${name}_${i}.sh
  sleep 1
  ((i=i+1))
done

