import sys

def compare_and_save(file1_path, file2_path, output_file_path):
    # Open the first file for reading
    with open(file1_path, 'r') as file1:
        lines1 = file1.readlines()

    # Open the second file for reading
    with open(file2_path, 'r') as file2:
        lines2 = file2.readlines()

    # Compare lines and save matching lines to a new file
    matching_lines = []
    for line1 in lines1:
        parts1 = line1.split()[:2]  # Get the first two parts of the line from file1

        for line2 in lines2:
            parts2 = line2.split()[:2]  # Get the first two parts of the line from file2

            if parts1 == parts2:  # Compare the first two parts
                matching_lines.append((line1.strip(), line2.strip()))
                break

    # Write the matching lines to the output file
    with open(output_file_path, 'w') as output_file:
        for line1, line2 in matching_lines:
            output_file.write(f"{line1}\t{line2}\n")

    num_input_lines1 = len(lines1)
    num_input_lines2 = len(lines2)
    num_output_lines = len(matching_lines)
    print("Number of input lines: {} for {} and {} for {}".format(num_input_lines1, str(sys.argv[1]), num_input_lines2, str(sys.argv[2])))
    print("Number of output lines written: {} saved to {}".format(num_output_lines, output_file_path))

# Check if the correct number of command-line arguments is provided
if len(sys.argv) != 4:
    print("Usage: python script.py file1.txt file2.txt output.txt")
else:
    # Extract the command-line arguments
    file1_path = sys.argv[1]
    file2_path = sys.argv[2]
    output_file_path = sys.argv[3]
    compare_and_save(file1_path, file2_path, output_file_path)

