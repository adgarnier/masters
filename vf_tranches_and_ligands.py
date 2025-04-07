import sys

def save_lines(input_file_path, output_file_path):
    # Open the input file for reading
    with open(input_file_path, 'r') as input_file:

        # Create a new file for writing
        with open(output_file_path, 'w') as output_file:

            # Create a list to store the extracted parts
            extracted_parts = []

            # Read each line from the input file
            for line in input_file:
                # Split the line into parts using whitespace as the delimiter
                parts = line.split()

                # Extract the first two parts
                first_part = parts[0]
                second_part = parts[1]

                # Add the extracted parts to the list
                extracted_parts.append(f"{first_part} {second_part}")

            # Sort the extracted parts in alphabetical order
            extracted_parts.sort()

            # Write the sorted parts to the output file
            for part in extracted_parts:
                output_file.write(f"{part}\n")

# Check if the correct number of command-line arguments is provided
if len(sys.argv) != 3:
    print("Usage: python script.py input.txt output.txt")
else:
    # Extract the command-line arguments
    input_file_path = sys.argv[1]
    output_file_path = sys.argv[2]
    save_lines(input_file_path, output_file_path)
    print("Extraction complete. The output has been saved to", output_file_path)

