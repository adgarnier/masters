import sys

# Check if the input file is provided as a command-line argument
if len(sys.argv) < 2:
    print("Please provide the input file as a command-line argument.")
    sys.exit(1)

input_file = sys.argv[1]

# Check if the output file name is provided as a command-line argument
if len(sys.argv) >= 3:
    output_file = sys.argv[2]
else:
    output_file = 'output.txt'

# Read the lines from the input file
with open(input_file, 'r') as file:
    lines = file.readlines()

# Extract the final number from each line
lines_with_numbers = []
for line in lines:
    elements = line.split()
    if len(elements) >= 2:
        try:
            number = float(elements[-1])
            lines_with_numbers.append((line, number))
        except ValueError:
            pass

# Sort the lines based on the extracted numbers in ascending order
sorted_lines = sorted(lines_with_numbers, key=lambda x: x[1])

# Write the sorted lines to a new file
with open(output_file, 'w') as file:
    for line, _ in sorted_lines:
        file.write(line)

# Print the total number of lines sorted
num_lines_sorted = len(sorted_lines)
print(f"Total number of lines sorted: {num_lines_sorted}, written to {output_file}.")

