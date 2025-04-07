import os
import tarfile

# Getting a list of tar files in the current directory
tar_files = [file for file in os.listdir() if file.endswith('.tar')]

# Extracting all tar files
for tar_file in tar_files:
    with tarfile.open(tar_file, 'r') as tar:
        tar.extractall()

    print(f"Extraction completed for {tar_file}")

print("All tar files have been extracted.")

