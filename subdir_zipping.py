import os
import zipfile
import sys
import shutil

def zip_subdirectories(directory, output_directory):
    # Get the list of subdirectories
    subdirectories = [subdir for subdir in os.listdir(directory) if os.path.isdir(os.path.join(directory, subdir))]

    # Create the output directory if it doesn't exist
    os.makedirs(output_directory, exist_ok=True)

    # Iterate through each subdirectory and create a zip file
    for subdir in subdirectories:
        subdir_path = os.path.join(directory, subdir)
        zip_filename = f"{subdir}.zip"
        zip_filepath = os.path.join(output_directory, zip_filename)

        with zipfile.ZipFile(zip_filepath, 'w') as zip_file:
            # Walk through the subdirectory and add each file to the zip file
            for foldername, subfolders, filenames in os.walk(subdir_path):
                for filename in filenames:
                    file_path = os.path.join(foldername, filename)
                    arcname = os.path.relpath(file_path, subdir_path)
                    zip_file.write(file_path, os.path.join(subdir, arcname))

        print(f"Zipped {subdir} into {zip_filepath}")

def unzip_files(zip_directory, output_directory):
    # Get the list of zip files
    zip_files = [zip_file for zip_file in os.listdir(zip_directory) if zip_file.endswith('.zip')]

    # Create the output directory if it doesn't exist
    os.makedirs(output_directory, exist_ok=True)

    # Iterate through each zip file and extract its contents
    for zip_file in zip_files:
        zip_filepath = os.path.join(zip_directory, zip_file)

        with zipfile.ZipFile(zip_filepath, 'r') as zip_ref:
            # Extract the contents of the zip file while preserving subdirectories
            zip_ref.extractall(output_directory)

        print(f"Extracted {zip_file} into {output_directory}")

if __name__ == "__main__":
    # Check if both directory and output_directory arguments are provided
    if len(sys.argv) != 3:
        print("Usage: python subdir_zipping.py <directory> <output_directory>")
        sys.exit(1)

    # Get the target directory and output directory from the command-line arguments
    target_directory = sys.argv[1]
    output_directory = sys.argv[2]

    # Check if the specified directory exists
    if not os.path.exists(target_directory) or not os.path.isdir(target_directory):
        print(f"Error: The specified directory '{target_directory}' does not exist.")
        sys.exit(1)

    # Call the function to zip subdirectories
    zip_subdirectories(target_directory, output_directory)

    # Optionally, you can uncomment the following line to unzip the files
    # unzip_files(output_directory, "/path/to/unzipped_files")
