import sys
import re

def count_numbers(file_path):
    numbers = {}
    total_lines = sum(1 for _ in open(file_path, 'r'))
    processed_lines = 0
    progress_threshold = total_lines // 100  # Update progress at every 1%

    with open(file_path, 'r') as file:
        for line in file:
            number = re.findall(r'\d*\.?\d+$', line)
            if number:
                number = float(number[0])
                if number in numbers:
                    numbers[number] += 1
                else:
                    numbers[number] = 1

            processed_lines += 1
            if processed_lines % progress_threshold == 0:
                progress = processed_lines / total_lines * 100
                sys.stdout.write(f"\rProgress: {progress:.2f}%")
                sys.stdout.flush()

    sys.stdout.write('\n')
    return numbers

def save_results(file_path, results):
    with open(file_path, 'w') as file:
        for number, count in results.items():
            file.write(f"-{number}\n")
            file.write(f"{count}\n")

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python script_name.py <input_file_path> <output_file_path>")
    else:
        input_file_path = sys.argv[1]
        output_file_path = sys.argv[2]

        result = count_numbers(input_file_path)
        save_results(output_file_path, result)

        print(f"Results saved to {output_file_path}.")

