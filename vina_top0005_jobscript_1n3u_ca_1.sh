#!/bin/bash
#SBATCH --job-name=1n3u_ca_job_1
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=00-03:00:00           # adjust this to match the walltime of your job
#SBATCH --cpus-per-task=1         # a MAXIMUM of 8 core, Alpafold has no benefit to use more
#SBATCH --mem=20G                 # adjust this according to the memory you need

# set the appropriate paths
BASE_PATH="/home/garnier/scratch/top0005"
RECEPTOR_PATH="${BASE_PATH}/hmox1_no_heme_1n3u.pdbqt"
LIGAND_DIR="${BASE_PATH}/top0005_pdbqts/subdir_1"
CONFIGS_DIR="${BASE_PATH}/configs_top0005/configs_top0005_1n3u_ca"
LOG_DIR="${BASE_PATH}/logs/logs_top0005_1n3u_ca/log_1"
OUTPUT_DIR="${BASE_PATH}/outputs//outputs_top0005_1n3u_ca//output_1"

date

module load autodock_vina

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
    zip -r -m log_1.zip ${LOG_DIR}
    zip -r -m output_1.zip ${OUTPUT_DIR}
    mkdir -p $LOG_DIR
    mkdir -p $OUTPUT_DIR
    echo
done

date

