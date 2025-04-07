#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <jobscript> <directory name> <# subdirectories>"
  exit 1
fi

name=$2
number=$3

if ! [[ $number =~ ^[0-9]+$ ]]; then
  echo "Error: Invalid input. Please provide a valid number."
  exit 1
fi

n=2
until [ $n -gt $number ]
do
  sed "s/subdir_1/subdir_${n}/g" $1 > vina_top0005_jobscript_${name}_$n.sh
  sed -i "s/job_1/job_${n}/g" vina_top0005_jobscript_${name}_$n.sh
  sed -i "s/log_1/log_${n}/g" vina_top0005_jobscript_${name}_$n.sh
  sed -i "s/output_1/output_${n}/g" vina_top0005_jobscript_${name}_$n.sh
  echo "Finished vina_top0005_${name}_$n.sh"
  ((n=n+1))
done


