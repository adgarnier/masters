# to find the files that still need to be unzipped
find . -name *.zip

# set the directories
export DOWNLOAD_DIR=$SCRATCH/alphafold/data
ROOT_DIR="${DOWNLOAD_DIR}/pdb_mmcif"
RAW_DIR="${ROOT_DIR}/raw"
MMCIF_DIR="${ROOT_DIR}/mmcif_files"

# removing all of a certain file and showing it
find ${RAW_DIR} -type f -name '*.cif' -exec rm --verbose {} +

# from ChatGPT to display the files being unzipped
find "${RAW_DIR}/" -type f -iname "*.gz" -print0 | while read -d $'\0' file; do echo "Unzipping ${file}..."; gunzip "${file}"; done

# can probably just edit the original script to complete the directory transfer and deletion

###

# from alphafold script "download_pdb_mmcif.sh"
# DOWNLOAD_DIR="$1"
# ROOT_DIR="${DOWNLOAD_DIR}/pdb_mmcif"
# RAW_DIR="${ROOT_DIR}/raw"
# MMCIF_DIR="${ROOT_DIR}/mmcif_files"

# echo "Unzipping all mmCIF files..."
# find "${RAW_DIR}/" -type f -iname "*.gz" -exec gunzip {} +

# echo "Flattening all mmCIF files..."
# mkdir --parents "${MMCIF_DIR}"
# find "${RAW_DIR}" -type d -empty -delete  # Delete empty directories.
# for subdir in "${RAW_DIR}"/*; do
#   mv "${subdir}/"*.cif "${MMCIF_DIR}"
# done

# Delete empty download directory structure.
# find "${RAW_DIR}" -type d -empty -delete

# wget "ftp://ftp.wwpdb.org/pub/pdb/data/status/obsolete.dat" -P "${ROOT_DIR}"
