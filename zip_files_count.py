#from chat

import os
import sys
import zipfile
import shutil

def count_files_in_zip_directory(directory, file_count=0):
    # Iterate over all files in the directory
    for file_name in os.listdir(directory):
        file_path = os.path.join(directory, file_name)

        # Check if the file is a zip file
        if zipfile.is_zipfile(file_path):
            with zipfile.ZipFile(file_path, 'r') as zip_ref:
                # Iterate over all files in the zip file
                for member in zip_ref.namelist():
                    # Check if the member is a directory
                    if member.endswith('/'):
                        # Extract the directory to a temporary location
                        zip_ref.extractall('./temp')

                        # Count the files in the extracted directory
                        subdirectory = os.path.join('./temp', member)
                        file_count = count_files_in_zip_directory(subdirectory, file_count)

                        # Clean up the extracted directory
                        shutil.rmtree(subdirectory)

                    else:
                        file_count += 1
                        print("Progress: Counting files -", file_count, end='\r')

    return file_count

if __name__ == '__main__':
    # Check if the directory path argument is provided
    if len(sys.argv) < 2:
        print("Please provide the directory path as an argument.")
        print("Usage: python zip_files_count.py <directory_path>")
        sys.exit(1)

    # Get the directory path from command line argument
    directory_path = sys.argv[1]

    # Check if the provided directory path exists
    if not os.path.exists(directory_path):
        print("Directory path does not exist.")
        sys.exit(1)

    # Count the files in all the subdirectories of zip files in the directory
    total_file_count = count_files_in_zip_directory(directory_path)

    print("\nTotal number of files:", total_file_count)
