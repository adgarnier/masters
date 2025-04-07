#!/bin/bash
#SBATCH --job-name=af_ca_job_1
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=01-00:00:00           # adjust this to match the walltime of your job
#SBATCH --cpus-per-task=8         # a MAXIMUM of 8 core, Alpafold has no benefit to use more
#SBATCH --mem=20G                 # adjust this according to the memory you need

# set the appropriate paths
RECEPTOR_PATH="//home//garnier//scratch//coconut//alphafold_hmox1_homodimer.pdbqt"
LIGAND_DIR="//home//garnier//ligands//coconut_pdbqt_subs//subdir_1"
CONFIGS_DIR="//home//garnier//scratch//coconut//configs//configs_123_af_ca"
LOG_DIR="//home//garnier//scratch//coconut//logs//logs_coconut_af_ca//log_1"
OUTPUT_DIR="//home//garnier//scratch//coconut//outputs//outputs_coconut_af_ca//output_1"

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

# isolate number from the ligand file names and use that for vina
for file in ${LIGAND_DIR}/*.pdbqt; do
    # extract the number from the file name using sed and regular expressions
    i=$(echo "$file" | sed 's/.*coconut\([0-9]*\).pdbqt/\1/')
    # print the file name and the extracted number
    echo "File: $file, Number: $i"

    vina \
    --receptor ${RECEPTOR_PATH} \
    --ligand ${LIGAND_DIR}/3d_hydrated_coconut${i}.pdbqt \
    --config ${CONFIGS_DIR}/config${i}.txt \
    --log ${LOG_DIR}/log_${i}.txt \
    --out ${OUTPUT_DIR}/output_${i}.pdbqt

    echo
    echo "Processed ligand ${i} for ${OUTPUT_DIR}"
    echo
    zip -r -m log_1.zip ${LOG_DIR}
    zip -r -m output_1.zip ${OUTPUT_DIR}
    mkdir -p $LOG_DIR
    mkdir -p $OUTPUT_DIR
    echo
done

date

