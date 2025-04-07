# set the appropriate paths
RECEPTOR_PATH="//home//garnier//hmox1//homodimer_hmox1//hmox1_no_heme_1n3u.pdbqt"
LIGAND_DIR="//home//garnier//hri/ligands//test//subdir_100"
CONFIGS_DIR="//home//garnier//hmox1//homodimer_hmox1//configs//configs_123//configs_123_1n3u_ca"
LOG_DIR="//home//garnier//hmox1//homodimer_hmox1//logs//logs_123_1n3u_ca//log_100"
OUTPUT_DIR="//home//garnier//hmox1//homodimer_hmox1//outputs_123_1n3u_ca//output_100"

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
done

zip -r  log_100.zip ${LOG_DIR}
mv log_100.zip ${LOG_DIR}//.
zip -r output_100.zip ${OUTPUT_DIR}
mv output_100.zip ${OUTPUT_DIR}
