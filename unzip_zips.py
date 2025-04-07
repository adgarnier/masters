import os
import zipfile
import sys

def extract_zip_files(directory):
    # Getting a list of zip files in the specified directory
    zip_files = [file for file in os.listdir(directory) if file.endswith('.zip')]

    # Extracting all zip files
    for zip_file in zip_files:
        with zipfile.ZipFile(os.path.join(directory, zip_file), 'r') as zip_ref:
            zip_ref.extractall(directory)

        print(f"Extraction completed for {zip_file}")

    print("All zip files have been extracted.")

if __name__ == "__main__":
    # Check if a directory argument is provided
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory>")
    else:
        directory = sys.argv[1]
        extract_zip_files(directory)

