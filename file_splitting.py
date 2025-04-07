import sys
import os

if len(sys.argv) != 2:
    print("Usage: python divide_file.py input_file.txt")
    sys.exit(1)

input_file_path = sys.argv[1]
input_file_name = os.path.basename(input_file_path)

with open(input_file_path, "r") as input_file:
    lines = input_file.readlines()

num_lines = len(lines)
num_files = 4
lines_per_file = (num_lines + num_files - 1) // num_files

for i in range(num_files):
    start = i * lines_per_file
    end = (i + 1) * lines_per_file
    with open(f"{os.path.splitext(input_file_name)[0]}_{i}.txt", "w") as output_file:
        output_file.writelines(lines[start:end])

