#!/bin/bash

# from ChatGPT to check that the variables were changed
# Ask the user a yes or no question
echo "Was FILE_PATH and sed changed to the appropriate directory? (y/n)"
read response

# Check the response and take appropriate action
if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
  # Do something if the response is "yes"
  echo "Continuing..."
elif [ "$response" = "n" ] || [ "$response" = "N" ]; then
  # Do something if the response is "no"
  echo "Exiting..."
  exit
else
  # Do something if the response is not "yes" or "no"
  echo "Invalid response. Please enter y or n."
fi

# set appropriate path
FILE_PATH="//home//garnier//hri//homodimer_eif2ak1//logs//logs_world_bc"
TEMP_PATH_1="//home//garnier//hri//homodimer_eif2ak1//logs//temp_file_1.txt"
TEMP_PATH_2="//home//garnier//hri//homodimer_eif2ak1//logs//temp_file_2.txt"
TEMP_PATH_3="//home//garnier//hri//homodimer_eif2ak1//logs//temp_file_3.txt"
SAVE_PATH="${FILE_PATH}//test.txt"

# make output file
echo "# File name identification (-10 to -11) for ${FILE_PATH}" >${SAVE_PATH}
echo >>${SAVE_PATH}
echo "# File number | Affinity" >>${SAVE_PATH}

# from 10 to 12
i=0
until [ $i -gt 2 ]
do
  echo "Identifying files for -1$i"
  h=0
  until [ $h -gt 9 ]
  do
    echo "-1$i.$h"
    grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[0-9][$i].[$h] -m 1 -H ${FILE_PATH}//log_* \
    >${TEMP_PATH_1}
    sed 's#//home//garnier//hri//homodimer_eif2ak1//logs//logs_world_bc//log_##g' ${TEMP_PATH_1} \
    >${TEMP_PATH_2}
    sed 's#.txt:   1      ##g' ${TEMP_PATH_2} \
    >${TEMP_PATH_3}
    sed 's#      0.000      0.000##g' ${TEMP_PATH_3} \
    >>${SAVE_PATH}
    echo ...
    ((h=h+1))
  done
  ((i=i+1))
done

# remove temporary files
sudo rm temp_file_*

# use this to change directory being looked in
# sed -i 's/logs_alphafold_ca/logs_alphafold_cb/g' identify_affinities_files.sh
