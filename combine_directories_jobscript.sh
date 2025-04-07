#!/bin/bash
#SBATCH --job-name=combine_directories
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=01-00:00:00           # adjust this to match the walltime of your job
#SBATCH --cpus-per-task=8         # a MAXIMUM of 8 core, Alpafold has no benefit to use more
#SBATCH --mem=20G                 # adjust this according to the memory you need

date

module load python/3.11.5

BASE_PATH="/home/garnier/scratch/jan2024"

python ${BASE_PATH}/combine_directories.py ${BASE_PATH}/coconut_a ${BASE_PATH}/coconut_b ${BASE_PATH}/coconut

date
