import sys
import glob
import argparse

def combine_files(input_files, output_file):
    combined_lines = []
    for file_name in input_files:
        with open(file_name, 'r') as input_file:
            combined_lines.extend(input_file.readlines())

    lines_with_numbers = []
    for line in combined_lines:
        elements = line.split()
        if len(elements) >= 2:
            try:
                number = float(elements[-1])
                lines_with_numbers.append((line, number))
            except ValueError:
                pass

    sorted_lines = sorted(lines_with_numbers, key=lambda x: x[1])

    with open(output_file, 'w') as output:
        for line, _ in sorted_lines:
            output.write(line)

    num_lines_sorted = len(sorted_lines)
    print(f"Combined {len(input_files)} file(s) with {num_lines_sorted} lines into {output_file}.")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input_files', nargs='+', help='Input files or wildcard pattern')
    parser.add_argument('output_file', help='Output file name')
    args = parser.parse_args()

    input_files = []
    for pattern in args.input_files:
        input_files.extend(glob.glob(pattern))

    if len(input_files) < 2:
        print("Please provide at least two input files.")
        sys.exit(1)

    combine_files(input_files, args.output_file)

