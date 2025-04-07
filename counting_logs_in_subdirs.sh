#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <name> <# subdirectories>"
  exit 1
fi

name=$1
number=$2

# check if the number is valid
if ! [[ $number =~ ^[0-9]+$ ]]; then
  echo "Error: Invalid input. Please provide a valid number."
  exit 1
fi

# unzip log files
echo "Unzipping files"
i=1
until [ $i -gt $number ]
do
  unzip log_$i.zip
  ((i=i+1))
done

echo " "

# mv log files to current directory
echo "Moving files to current directory"
m=1
until [ $m -gt $number ]
do
  mv home/garnier/scratch/top0005/logs/logs_top0005_$name/log_$m/ .
  echo "Moved log_$m"
  ((m=m+1))
done

echo " "

# count the number of files in each subdirectory
echo "Counting number of files in each subdirectory"
n=1
until [ $n -gt $number ]
do
  echo "log $n count:"
  ls log_$n/ | wc -l
  ((n=n+1))
done

echo " "

# move the zip files
echo "Moving zip files to zips directory"
ZIP_DIR="./zips"
if [ ! -d "$ZIP_DIR" ]; then
  mkdir -p "$ZIP_DIR"
  echo "Created ${ZIP_DIR}"
  echo
fi

mv *.zip zips
rm -r home

echo "Done."
