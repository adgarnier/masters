#!/bin/bash

# make sure to give reading, writing and editing permissions
# chmod 755 -R <directory>

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <directory> <# subdirectories>"
  exit 1
fi

name=$1
number=$2

# check if the number is a number
if ! [[ $number =~ ^[0-9]+$ ]]; then
  echo "Error: Invalid input. Please provide a valid number."
  exit 1
fi

# set appropriate paths
BASE_PATH="//home//garnier//hmox1//homodimer_hmox1//virtualflow//top0005//logs_top0005//logs_$name"
TEMP_DIR="${BASE_PATH}//temp"
TEMP_PATH_1="${TEMP_DIR}//temp_file_1.txt"
TEMP_PATH_2="${TEMP_DIR}//temp_file_2.txt"
TEMP_PATH_3="${TEMP_DIR}//temp_file_3.txt"
SAVE_PATH="${BASE_PATH}//affinity_file_names.txt"

# make directory for temp files
if [ ! -d "$TEMP_DIR" ]; then
  mkdir -p "$TEMP_DIR"
fi

sudo chmod -R ${BASE_PATH}

# make output file
echo "# File name identification for ${BASE_PATH}" >${SAVE_PATH}
echo >>${SAVE_PATH}
echo "# File number | Affinity" >>${SAVE_PATH}

# go through every subdir (log_#) taking every binding affinity from 0.0 to 9.9
p=1
until [ $p -gt $number ]
do
  FILE_PATH="${BASE_PATH}//log_${p}"
  basename "$FILE_PATH"
  b="$(basename -- $FILE_PATH)"
  i=0
  until [ $i -gt 9 ]
  do
    echo "Identifying files for -$i in $b"
    h=0
    until [ $h -gt 9 ]
    do
      echo "-$i.$h"
      grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[$i].[$h] -m 1 -H ${FILE_PATH}//log_* \
      >${TEMP_PATH_1}
      sed "s#//home//garnier//hmox1//homodimer_hmox1//virtualflow//top0005//logs_top0005//logs_$name//log_${p}//log_##g" ${TEMP_PATH_1} \
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
  ((p=p+1))
done

# go through every subdir (log_#) taking every binding affinity from 10.0 to 19.9
p=1
until [ $p -gt $number ]
do
  FILE_PATH="${BASE_PATH}//log_${p}"
  basename "$FILE_PATH"
  b="$(basename -- $FILE_PATH)"
  i=0
  until [ $i -gt 9 ]
  do
    echo "Identifying files for -1$i in $b"
    h=0
    until [ $h -gt 9 ]
    do
      echo "-1$i.$h"
      grep -e [1][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9][^0-9]-[0-9][$i].[$h] -m 1 -H ${FILE_PATH}//log_* \
      >${TEMP_PATH_1}
      sed "s#//home//garnier//hmox1//homodimer_hmox1//virtualflow//top0005//logs_top0005//logs_$name//log_${p}//log_##g" ${TEMP_PATH_1} \
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
  ((p=p+1))
done

# remove temporary files
sudo rm -r ${TEMP_DIR}

