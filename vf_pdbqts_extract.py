import tarfile
import os
import sys

def extract_pdbqt_from_tar(tar_path, wildcard_pattern, destination_path):
    try:
        with tarfile.open(tar_path, 'r:gz') as tar:
            matching_files = [member for member in tar.getmembers() if wildcard_pattern in member.name]
            if len(matching_files) == 0:
                print(f"No matching files found in {tar_path} for pattern '{wildcard_pattern}'")
                return

            for file in matching_files:
                file.name = os.path.basename(file.name)  # Set the file name to just the basename
                tar.extract(file, path=destination_path)

        print(f"Extraction successful: {tar_path}, {wildcard_pattern}")
    except tarfile.TarError as e:
        print(f"Extraction failed for {tar_path}: {str(e)}")


def extract_files_from_list(file_path, destination_path):
    try:
        if not os.path.exists(destination_path):
            os.makedirs(destination_path)

        with open(file_path, 'r') as file:
            for line in file:
                line = line.strip()
                if len(line) < 18:
                    print(f"Invalid line: {line}")
                    continue

                de = line[:2]
                debbad = line[:6]
                number = line.split('_')[1][:5]
                second_part = line.split()[1]
                tar_path = f'{de}/{debbad}/{number}.tar.gz'
                wildcard_pattern = f'{second_part}.pdbqt'
                # print(f"Attempting extraction: tar_path={tar_path}, wildcard_pattern={wildcard_pattern}")
                extract_pdbqt_from_tar(tar_path, wildcard_pattern, destination_path)

        print("Extraction completed")
    except IOError as e:
        print(f"Error reading file: {str(e)}")

# Usage example
if __name__ == "__main__":
    # Check if the file path is provided as a command line argument
    if len(sys.argv) < 2:
        print("Usage: python script.py input.txt")
        sys.exit(1)

    file_path = sys.argv[1]  # Get the file path from command line argument
    destination_path = './top0005_pdbqts'  # Destination path for extracted files

    extract_files_from_list(file_path, destination_path)

