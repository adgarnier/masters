#!/bin/bash
#SBATCH --job-name=alphafold_run
#SBATCH --account=def-shuang    # adjust this to match the accounting group you are using to submit jobs
#SBATCH --time=08:00:00           # adjust this to match the walltime of your job
#SBATCH --cpus-per-task=8         # a MAXIMUM of 8 core, Alpafold has no benefit to use more
#SBATCH --mem=20G                 # adjust this according to the memory you need

date

# Load modules dependencies
module load gcc/9.3.0 openmpi/4.0.3 cuda/11.4 cudnn/8.2.0 kalign/2.03 hmmer/3.2.1 openmm-alphafold/7.5.1 hh-suite/3.3.0 python/3.8

DOWNLOAD_DIR=$SCRATCH/alphafold/data # set the appropriate path to your downloaded data
INPUT_DIR=$SCRATCH/alphafold/input     # set the appropriate path to your supporting data
OUTPUT_DIR=${SCRATCH}/alphafold/output # set the appropriate path to your supporting data

# Virtual environment to match that made in setup
virtualenv --no-download ~/alphafold_env
source ~/alphafold_env/bin/activate

# Install alphafold and its dependencies
pip install --no-index --upgrade pip
pip install --no-index --requirement ~/alphafold-requirements.txt

# Edit with the proper arguments, run your commands
# run_alphafold.py --help
run_alphafold.py \
--data_dir=${DOWNLOAD_DIR} \
--fasta_paths=${INPUT_DIR}/eif2ak1_homodimer_iso1.fasta \
--db_preset=reduced_dbs \
--small_bfd_database_path=${DOWNLOAD_DIR}/small_bfd/bfd-first_non_consensus_sequences.fasta \
--template_mmcif_dir=${DOWNLOAD_DIR}/pdb_mmcif/mmcif_files \
--uniref90_database_path=${DOWNLOAD_DIR}/uniref90/uniref90.fasta \
--hhblits_binary_path=${EBROOTHHMINSUITE}/bin/hhblits \
--hhsearch_binary_path=${EBROOTHHMINSUITE}/bin/hhsearch \
--jackhmmer_binary_path=${EBROOTHMMER}/bin/jackhmmer \
--kalign_binary_path=${EBROOTKALIGN}/bin/kalign \
--mgnify_database_path=${DOWNLOAD_DIR}/mgnify/mgy_clusters_2018_12.fa \
--output_dir=${OUTPUT_DIR} \
--obsolete_pdbs_path=${DOWNLOAD_DIR}/pdb_mmcif/obsolete.dat \
--model_preset=multimer --num_multimer_predictions_per_model=5 \
--use_gpu_relax=False \
--max_template_date=2022-11-07 \
--pdb_seqres_database_path=${DOWNLOAD_DIR}/pdb_seqres/pdb_seqres.txt \
--uniprot_database_path=${DOWNLOAD_DIR}/uniprot 

date
