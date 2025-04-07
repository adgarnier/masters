#!/bin/bash
#SBATCH --job-name=1ni6_cb_job_1
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=01-00:00:00           # adjust this to match the walltime of your job
#SBATCH --cpus-per-task=8         # a MAXIMUM of 8 core, Alpafold has no benefit to use more
#SBATCH --mem=20G                 # adjust this according to the memory you need

# set the appropriate paths
BASE_PATH="/home/garnier/hmox1/homodimer_hmox1"
RECEPTOR_PATH="${BASE_PATH}/hmox1_no_heme_1n3u.pdbqt"
LIGAND_DIR="/home/garnier/hri/ligands/top0005_pdbqts"
CONFIGS_DIR="${BASE_PATH}/configs/configs_top0005/configs_top0005_1n3u_ca"
LOG_DIR="${BASE_PATH}/logs/logs_test/logs_top0005_1n3u_ca"
OUTPUT_DIR="${BASE_PATH}/outputs/outputs_test/outputs_top0005_1n3u_ca"

#module load autodock_vina

# check and make log and output directories if needed
if [ ! -d "$LOG_DIR" ]; then
  mkdir -p "$LOG_DIR"
  echo "Created ${LOG_DIR}"
  echo
fi

if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
  echo "Created ${OUTPUT_DIR}"
  echo
fi

# isolate file name from the ligand file names and use that for vina
for file in "${LIGAND_DIR}"/*.pdbqt; do
    # extract the file name without the directory path and extension
    filename=$(basename "$file" .pdbqt)
    # print the file name and the extracted number
    echo "File: $file, Filename: $filename"
    
    vina \
    --receptor "${RECEPTOR_PATH}" \
    --ligand "${LIGAND_DIR}/${filename}.pdbqt" \
    --config "${CONFIGS_DIR}/${filename}.txt" \
    --log "${LOG_DIR}/log_${filename}.txt" \
    --out "${OUTPUT_DIR}/output_${filename}.pdbqt"

    echo
    echo "Processed ${filename} for ${OUTPUT_DIR}"
    echo
done

