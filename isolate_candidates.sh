#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

out="candidates"

if [ ! -d "$out" ]; then
  mkdir -p "$out"
  echo "Created ${out}"
  echo
fi

dir=$1

# unzip everything
echo "###################################"
echo "          Unzipping files          "
echo "###################################"
cp ~/hri/scripts/unzip_zips.py ${PWD}
python ${PWD}/unzip_zips.py
rm ${PWD}/unzip_zips.py
echo

echo "###################################"
echo "          Moving ligands           "
echo "###################################"
# Assign the list to a variable as an array
my_list=(
  "Z2460788182_2_T1"
  "Z1902113719_71_T2"
  "Z1951701720_237_T2"
  "Z2184875336_10"
  "Z2624918446_2"
  "Z1907360844_189"
  "Z2779098280_370_T1"
  "Z1983290226_1_T2"
  "Z1630002845_4_T2"
  "Z1907683511_226"
  "Z2822107436_6_T1"
  "Z2803214055_3_T1"
  "Z2723004710_66_T1"
  "Z1905021759_159"
  "Z2838360160_1_T1"
  "Z2711912609_16_T1"
)

# Access and use the values in the array
for item in "${my_list[@]}"
do
  echo "$item"
  line=$(find | grep $item)
  # Extract the last directory name containing "output_21"
  directory=$(basename "$(dirname "$line")")
  # Use regular expressions to isolate one or two digits
  if [[ $directory =~ output_([0-9]{1,2}) ]]; then
    digits=${BASH_REMATCH[1]}
    echo "Found in output_$digits"
  else
    echo "Could not determine output directory."
  fi
  mv home/garnier/scratch/top0005/outputs/outputs_top0005_${dir}/output_${digits}/output_${item}.pdbqt ${out}
  echo "Moved output_${item}.pdbqt to ${out}"
done
rm -r home
echo 
echo "Complete."
