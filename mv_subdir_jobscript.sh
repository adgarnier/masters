#!/bin/bash
#SBATCH --job-name=mv_subdir
#SBATCH --account=def-shuang
#SBATCH --time=0-00:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G

date

BASE_PATH="/home/garnier/scratch/jan2024/configs_vf_ca"

i=1
until [ $i -gt 26 ]
do
  mv ${BASE_PATH}/subdir_$i/* ${BASE_PATH}
  echo
  echo "Moved subdir_$i"
  ((i=i+1))
done

date

