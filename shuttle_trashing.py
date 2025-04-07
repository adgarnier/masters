import os
import shutil

src_dir = "//home//garnier//hri//ligands//coconut_remainder_2"
dst_dir = "//home//garnier//hri//ligands//coconut_trash_2"

if not os.path.exists(dst_dir):
    os.mkdir(dst_dir)

search_term = input("Enter the search term: ")

counter= 0

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
                if '>  <name>' in line:
                    # Get the next line
                    next_line = lines[i+1]
                    # Check if the next line is three consecutive digits followed by a period
                    if next_line.startswith(search_term):
                        # Copy the file to the destination directory
                        shutil.move(filepath, os.path.join(dst_dir, filename))
                        print("Shuttled: " + filepath)
                        counter+= +1
                        # Exit the loop since we've found what we're looking for
                        break

print(str(counter) + " files trashed")
