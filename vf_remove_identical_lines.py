import sys


def remove_identical_lines(file1, file2, output_file):
    # Read lines from both files
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

    # Remove identical lines
    removed_lines = []
    for line1 in lines1:
        line1_parts = line1.strip().split()[:2]  # Compare the first two parts of the line
        match_found = False
        for line2 in lines2:
            line2_parts = line2.strip().split()[:2]  # Compare the first two parts of the line
            if line1_parts == line2_parts:
                match_found = True
                break
        if not match_found:
            removed_lines.append(line1)

    # Write the updated lines to the output file
    with open(output_file, 'w') as f:
        f.writelines(removed_lines)

    num_lines_removed = len(lines1) - len(removed_lines)
    print(f"{num_lines_removed} lines removed successfully.")


# Check if all three file paths are provided as command line arguments
if len(sys.argv) != 4:
    print("Usage: python script.py <file1> <file2> <output_file>")
    sys.exit(1)

# Get file paths from command line arguments
file1_path = sys.argv[1]
file2_path = sys.argv[2]
output_file_path = sys.argv[3]

# Remove identical lines and save to the output file
remove_identical_lines(file1_path, file2_path, output_file_path)

