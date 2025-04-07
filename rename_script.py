# renames all files in a directory from 3d_hydrated_coconut* to coconut*

import os
import re
import sys

def rename_files(directory_path):
    # Get a list of all files in the directory
    files = os.listdir(directory_path)

    # Define a regular expression pattern to extract the variable number from the filename
    pattern = re.compile(r'3d_hydrated_coconut(\d+).pdbqt')

    for file_name in files:
        # Check if the filename matches the pattern
        match = pattern.match(file_name)

        if match:
            # Extract the variable number from the filename
            variable_number = match.group(1)

            # Construct the new filename
            new_file_name = f'coconut{variable_number}.pdbqt'

            # Build the full paths for the old and new filenames
            old_path = os.path.join(directory_path, file_name)
            new_path = os.path.join(directory_path, new_file_name)

            # Rename the file
            os.rename(old_path, new_path)

            print(f'Renamed: {file_name} to {new_file_name}')

if __name__ == "__main__":
    # Check if a directory path is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python script.py /path/to/your/directory")
        sys.exit(1)

    # Get the directory path from the command-line argument
    directory_path = sys.argv[1]

    # Call the function to rename files in the specified directory
    rename_files(directory_path)

