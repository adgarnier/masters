#!/bin/bash

# Check if the input file is specified
if [ $# -lt 1 ]; then
    echo "Please specify the input file"
    exit 1
fi

# Get the input file name
input_file=$1

# Set the output file name
output_file=${input_file/h119/c411}

# Use the sed command to replace h119 with c411 in the input file
# and save the output to the output file
sed "s/h119/c411/g" $input_file > $output_file

