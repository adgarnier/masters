#!/bin/bash
#SBATCH --job-name=bc_456
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=12-00:00:00           # adjust this to match the walltime of your job
#SBATCH --cpus-per-task=8         # a MAXIMUM of 8 core, Alpafold has no benefit to use more
#SBATCH --mem=20G                 # adjust this according to the memory you need

# set the appropriate paths
RECEPTOR_PATH="//home//garnier//vina_screen//coconut//alphafold_eif2ak1_homodimer.pdbqt"
LIGAND_PATH="//home//garnier/vina_screen//ligands//coconut"
CONFIGS_PATH="//home//garnier//vina_screen//coconut//configs//configs_world_bc"
LOG_PATH="//home//garnier//vina_screen//coconut//logs//logs_world_bc"
OUTPUT_PATH="//home//garnier//vina_screen//coconut//outputs//outputs_world_bc"

date

module load autodock_vina

# going through 40603 ligands
# set the first digit
n=4
until [ $n -gt 6 ]
do
  # increment the number for each run vina
  # 4/5/6
  i=${n}
  until [ $i -gt ${n} ]
  do
    vina \
    --receptor ${RECEPTOR_PATH} \
    --ligand ${LIGAND_PATH}//world$i.pdbqt \
    --config ${CONFIGS_PATH}//config$i.txt \
    --log ${LOG_PATH}//log_$i.txt \
    --out ${OUTPUT_PATH}//output_$i.pdbqt
    echo
    echo "Processed ligand $i for ${OUTPUT_PATH}"
    echo
    ((i=i+1))
  done

  # 40/50/60
  i=${n}0
  until [ $i -gt ${n}9 ]
  do
    vina \
    --receptor ${RECEPTOR_PATH} \
    --ligand ${LIGAND_PATH}//world$i.pdbqt \
    --config ${CONFIGS_PATH}//config$i.txt \
    --log ${LOG_PATH}//log_$i.txt \
    --out ${OUTPUT_PATH}//output_$i.pdbqt
    echo
    echo "Processed ligand $i for ${OUTPUT_PATH}"
    echo
    ((i=i+1))
  done

  # 400/500/600
  i=${n}00
  until [ $i -gt ${n}99 ]
  do
    vina \
    --receptor ${RECEPTOR_PATH} \
    --ligand ${LIGAND_PATH}//world$i.pdbqt \
    --config ${CONFIGS_PATH}//config$i.txt \
    --log ${LOG_PATH}//log_$i.txt \
    --out ${OUTPUT_PATH}//output_$i.pdbqt
    echo
    echo "Processed ligand $i for ${OUTPUT_PATH}"
    echo
    ((i=i+1))
  done

  # 4000/5000/6000
  i=${n}000
  until [ $i -gt ${n}999 ]
  do
    vina \
    --receptor ${RECEPTOR_PATH} \
    --ligand ${LIGAND_PATH}//world$i.pdbqt \
    --config ${CONFIGS_PATH}//config$i.txt \
    --log ${LOG_PATH}//log_$i.txt \
    --out ${OUTPUT_PATH}//output_$i.pdbqt
    echo
    echo "Processed ligand $i for ${OUTPUT_PATH}"
    echo
    ((i=i+1))
  done

  # 40000/50000/60000
  i=${n}0000
  until [ $i -gt ${n}9999 ]
  do
    vina \
    --receptor ${RECEPTOR_PATH} \
    --ligand ${LIGAND_PATH}//world$i.pdbqt \
    --config ${CONFIGS_PATH}//config$i.txt \
    --log ${LOG_PATH}//log_$i.txt \
    --out ${OUTPUT_PATH}//output_$i.pdbqt
    echo
    echo "Processed ligand $i for ${OUTPUT_PATH}"
    echo
    ((i=i+1))
  done
  ((n=n+1))
done

# add in the extra 7270 above 400000
i=400000
until [ $i -gt 407270 ]
do
  vina \
  --receptor ${RECEPTOR_PATH} \
  --ligand ${LIGAND_PATH}//world$i.pdbqt \
  --config ${CONFIGS_PATH}//config$i.txt \
  --log ${LOG_PATH}//log_$i.txt \
  --out ${OUTPUT_PATH}//output_$i.pdbqt
  echo
  echo "Processed ligand $i for ${OUTPUT_PATH}"
  echo
  ((i=i+1))
done

date

