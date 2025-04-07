#!/bin/bash

if [[ $# -ne 0 ]]; then
  echo "Usage: $0"
  exit 1
fi

out="candidates"

if [ ! -d "$out" ]; then
  mkdir -p "$out"
  echo "Created ${out}"
  echo
fi

echo "###################################"
echo "          Moving ligands           "
echo "###################################"
# Assign the list to a variable as an array
my_list=(
  "PV-000531003998_4_T1"
  "Z2706861795_3"
  "Z2803161069_94_T1"
  "Z2804497766_3_T1"
)

# Access and use the values in the array
for item in "${my_list[@]}"
do
  echo "$item"
  line=$(find | grep $item)
  # Extract the last directory name containing "output_21"
  directory=$(basename "$(dirname "$line")")
  # Use regular expressions to isolate one or two digits
  if [[ $directory =~ subdir_([0-9]{1,2}) ]]; then
    digits=${BASH_REMATCH[1]}
    echo "Found in subdir_$digits"
  else
    echo "Could not determine output directory."
  fi
  cp ./subdir_${digits}/${item}.pdbqt ${out}
  echo "Copied ${item}.pdbqt to ${out}"
done
echo
echo "Complete."

