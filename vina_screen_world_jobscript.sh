#!/bin/bash
#SBATCH --job-name=vina_screen
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=1-00:00:00           # adjust this to match the walltime of your job
#SBATCH --cpus-per-task=8         # a MAXIMUM of 8 core, Alpafold has no benefit to use more
#SBATCH --mem=20G                 # adjust this according to the memory you need

# set the appropriate paths
RECEPTOR_PATH="//home//garnier//vina_screen//alphafold_eif2ak1_homodimer.pdbqt"
LIGAND_PATH="//home//garnier/vina_screen//ligands//world"
CONFIGS_PATH="//home//garnier//vina_screen//configs_world"
LOG_PATH="//home//garnier//vina_screen//logs_world"
OUTPUT_PATH="//home//garnier//vina_screen//outputs_world"

date

module load autodock_vina

# this is the number that needs to be the end of the vina runs
# i.e. [ $i -gt ls $LIGAND_PATH | wc -l ]
# ls $LIGAND_PATH | wc -l
# 5904

# increment the number for each run vina
i=1
until [ $i -gt 5904 ]
do
  vina \
  --receptor ${RECEPTOR_PATH} \
  --ligand ${LIGAND_PATH}//world$i.pdbqt \
  --config ${CONFIGS_PATH}//config$i.txt \
  --log ${LOG_PATH}//log_$i.txt \
  --out ${OUTPUT_PATH}//output_$i.pdbqt
  echo
  echo "Processed ligand $i"
  echo
  ((i=i+1))
done

date

