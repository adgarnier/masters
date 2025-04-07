import sys

def find_coconut_id(file_path, target_numbers):
    result_dict = {}

    for target_number in target_numbers:
        # Construct the file name based on the current target number
        file_name = f"hydrated_coconut{target_number}.sdf"

        try:
            # Open the file and search for ">  <coconut_id>"
            with open(file_path + file_name, 'r') as file:
                lines = file.readlines()
                for i, line in enumerate(lines):
                    if ">  <name>" in line:
                        # Store the line after ">  <coconut_id>" in the result dictionary
                        coconut_id_line = lines[i + 1].strip()
                        result_dict[target_number] = coconut_id_line
                        break  # Break out of the loop once the target is found

            # If ">  <coconut_id>" is not found
            if target_number not in result_dict:
                result_dict[target_number] = f"Error: '>  <name>' not found in {file_name}"

        except FileNotFoundError:
            result_dict[target_number] = f"Error: File {file_name} not found"

    return result_dict

if __name__ == "__main__":
    # Check if the correct number of command-line arguments is provided
    if len(sys.argv) != 3:
        print("Usage: python isolate_coconut_name.py <sdf_file_directory> <comma_separated_number_list>")
        sys.exit(1)

    # Extract the command-line arguments
    file_path = sys.argv[1]
    input_numbers = sys.argv[2]

    # Convert the input_numbers string to a list of integers
    target_numbers = [int(num.strip()) for num in input_numbers.split(',')]

    # Call the function and print the result
    results = find_coconut_id(file_path, target_numbers)
    
    # Print the results for each target number
    for num, result in results.items():
        print(f"Result for number {num}: {result}")

