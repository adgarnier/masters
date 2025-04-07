#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <directory> <# files per subdirectory>"
  exit 1
fi

dir_path=$1
number=$2

# Check if the directory exists
if [ ! -d "$dir_path" ]; then
  echo "Error: Directory does not exist"
  exit 1
fi

# check if the number is a number
if ! [[ $number =~ ^[0-9]+$ ]]; then
  echo "Error: Invalid input. Please provide a valid number."
  exit 1
fi

# set the file counter and subdirectory counter
count=0
subdir_count=1

# loop through all files in the directory
for file in "${dir_path}"/*; do
  # create a new subdirectory if we've hit the limit of $number files per subdirectory
  if [ $count -eq 0 ]; then
    mkdir "${dir_path}/subdir_${subdir_count}"
    ((subdir_count++))
  fi

  # move the current file into the current subdirectory
  mv "$file" "${dir_path}/subdir_$((subdir_count-1))/"

  echo "Moved $file to subdir_$((subdir_count-1))"

  # increment the file counter
  ((count++))

  # reset the file counter if we've hit the limit of $number files per subdirectory
  if [ $count -eq $number ]; then
    count=0
  fi
done
echo "$((subdir_count-1)) subdirectories made with $number ligands each"
