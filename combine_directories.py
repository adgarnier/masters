import os
import shutil
import sys

def merge_directories(directory_a, directory_b, output_directory):
    # Create the output directory if it doesn't exist
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    # Get a list of files in both directories
    files_a = os.listdir(directory_a)
    files_b = os.listdir(directory_b)

    # Combine files from both directories
    for file_name in set(files_a + files_b):
        file_path_a = os.path.join(directory_a, file_name)
        file_path_b = os.path.join(directory_b, file_name)

        # Check if the file exists in both directories
        if os.path.exists(file_path_a) and os.path.exists(file_path_b):
            # Combine content from both files
            with open(file_path_a, 'rb') as file_a, open(file_path_b, 'rb') as file_b:
                combined_content = file_a.read() + file_b.read()

            # Write the combined content to the output directory
            output_path = os.path.join(output_directory, file_name)
            with open(output_path, 'wb') as combined_file:
                combined_file.write(combined_content)

            print(f'Merged: {file_name}')
        else:
            # Copy the file from the directory that contains it
            source_path = file_path_a if os.path.exists(file_path_a) else file_path_b
            shutil.copy(source_path, os.path.join(output_directory, file_name))
            print(f'Copied: {file_name}')

if __name__ == "__main__":
    # Check if three command-line arguments are provided
    if len(sys.argv) != 4:
        print("Usage: python script.py /path/to/directory_a /path/to/directory_b /path/to/output_directory")
        sys.exit(1)

    # Get the input directory paths and the output directory path from command-line arguments
    directory_a = sys.argv[1]
    directory_b = sys.argv[2]
    output_directory = sys.argv[3]

    # Call the function to merge files from both directories
    merge_directories(directory_a, directory_b, output_directory)

