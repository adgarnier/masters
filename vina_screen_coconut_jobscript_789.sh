#!/bin/bash
#SBATCH --job-name=bc_789
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=10-00:00:00           # adjust this to match the walltime of your job
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

# going through 33333 ligands
# set the first digit
n=7
until [ $n -gt 9 ]
do
  # increment the number for each run vina
  # 7/8/9
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

  # 70/80/90
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

  # 700/800/900
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

  # 7000/8000/9000
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

  # 70000/80000/90000
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

date

