import os
import shutil

src_dir = "//home//garnier//hri//ligands//coconut_remainder_1"
dst_dir = "//home//garnier//hri//ligands//coconut_remainder_2"

if not os.path.exists(dst_dir):
    os.mkdir(dst_dir)

# Loop through each file in the source directory
for filename in os.listdir(src_dir):
    # Create the full path to the file
    filepath = os.path.join(src_dir, filename)
    # Check if the file is a regular file
    if os.path.isfile(filepath):
        # Open the file for reading
        with open(filepath, 'r') as f:
            # Read the contents of the file
            contents = f.read()
            # Split the contents into lines
            lines = contents.split('\n')
            # Loop through each line in the file
            for i, line in enumerate(lines):
                # Check if the line contains "> <name>"
                if '>  <molecular_weight>' in line:
                    # Get the next line
                    next_line = lines[i+1]
                    # Check if the next line is three consecutive digits followed by a period
                    if len(next_line) > 3 and next_line[3] == '.':
                        # Copy the file to the destination directory
                        shutil.copy(filepath, os.path.join(dst_dir, filename))
                        print("Shuttled: " + filepath)
                        # Exit the loop since we've found what we're looking for
                        break
