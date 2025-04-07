#! /bin/bash

# set the appropriate paths
RECEPTOR_PATH="//home//garnier//hri//homodimer_eif2ak1//alphafold_eif2ak1_homodimer.pdbqt"
LIGAND_PATH="//home//garnier/hri//ligands//world"
CONFIGS_PATH="//home//garnier/hri//homodimer_eif2ak1//configs//configs_world"
LOG_PATH="//home//garnier/hri//homodimer_eif2ak1//logs//logs_world"
OUTPUT_PATH="//home//garnier/hri//homodimer_eif2ak1//outputs//outputs_world"

# this is the number that needs to be the end of the vina runs
# i.e. [ $i -gt ls $LIGAND_PATH | wc -l ]
# ls $LIGAND_PATH | wc -l
# 5904

# increment the number for each run vina
i=1
until [ $i -gt 3 ]
do
  vina \
  --receptor ${RECEPTOR_PATH} \
  --ligand ${LIGAND_PATH}//world$i.pdbqt \
  --config ${CONFIGS_PATH}//config$i.txt \
  --log ${LOG_PATH}//log_$i.txt \
  --out ${OUTPUT_PATH}//output_$i.pdbqt
  echo
  echo "Processing ligand $i"
  echo
  ((i=i+1))
done
