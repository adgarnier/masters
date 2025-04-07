import os
import shutil

source_dir = "//home//garnier//hri//ligands//coconut_remainder_2"
target_dir = "//home//garnier//hri//ligands//coconut_remainder_3"

if not os.path.exists(target_dir):
    os.mkdir(target_dir)

counter= 0

for filename in os.listdir(source_dir):
    filepath = os.path.join(source_dir, filename)
    if os.path.isfile(filepath):
        with open(filepath, "r") as f:
            lines = f.readlines()
            counter+= +1
            for i in range(len(lines)):
                if ">  <name>" in lines[i]:
                    name_line = lines[i+1].strip()
                    if name_line.strip() and name_line[0].isalpha():
                        target_path = os.path.join(target_dir, filename)
                        shutil.copyfile(filepath, target_path)
                        print("Shuttled; " + filepath)
                        break
