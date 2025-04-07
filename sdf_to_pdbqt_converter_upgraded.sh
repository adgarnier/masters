#!/bin/bash

# need to run the script in the folder with the ligands, the output can go somewhere else
OUTPUT_PATH="//home//garnier//hri//ligands//coconut_pdbqt"

if [ ! -d "$OUTPUT_PATH" ]; then
  mkdir -p "$OUTPUT_PATH"
fi

# loop through and prepare ligands
for file in *.sdf; do
  base=$(basename "$file" .sdf)
  //home//garnier//anaconda3//bin//mk_prepare_ligand.py -i "$file" -o "${OUTPUT_PATH}/${base}.pdbqt"
  echo "converted $file from .sdf to .pdbqt"
done
