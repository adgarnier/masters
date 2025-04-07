#!/bin/bash

# made using ChatGPT
# Get the file name from the first command line argument
filename=$1

# Check if the file exists
if [ ! -f "$filename" ]; then
  echo "Error: File does not exist"
  exit 1
fi

# Replace "vina_screen" with "scratch" in the file and save the modified version
sed 's/vina_screen/scratch/g' "$filename" > "$filename.tmp" && mv "$filename.tmp" "$filename"

echo "Done!"

