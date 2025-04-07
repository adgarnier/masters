import os
import sys

# Check if the command line argument is provided
if len(sys.argv) != 2:
    print("Usage: python script.py <name>")
    sys.exit(1)

# Extract the command line argument
name= sys.argv[1]

COCONUT_FOLDER_PATH="//home//garnier//hmox1//qsr//top0005_pdbqts_qsr//candidates"
EBOX_LOCATION_PATH="//home//garnier//hri//homodimer_eif2ak1//eboxsize//eboxsize.pl"
CONFIG_FOLDER_PATH="//home//garnier//hmox1//qsr//hemoproteins//configs//configs_" + name
CONFIG_FORMAT_PATH="//home//garnier//hmox1//qsr//hemoproteins//configs//configs_" + name + "//CONFIG_FORMAT.txt"

CONFIG_FORMAT=open(CONFIG_FORMAT_PATH, 'r').read()


# First we want all the worlds.
coconuts= os.listdir(COCONUT_FOLDER_PATH)

list_of_eboxed_guys=[]

counter= 0

# do some eboxin on each file
for coconut in coconuts:

    ebox_guy_stream = os.popen('sudo {0} {1}//{2}'.format(EBOX_LOCATION_PATH,COCONUT_FOLDER_PATH,coconut))
    ebox_guy=ebox_guy_stream.read()
    list_of_eboxed_guys.append( (ebox_guy, coconut))

    counter+= +1
    print("ebox-ing ligand " + str(counter) + " " + CONFIG_FOLDER_PATH[67:])

for ebox_guy in list_of_eboxed_guys:
    file_to_save=CONFIG_FOLDER_PATH+"//" + ebox_guy[1]
    ligand_path=ebox_guy[1]

    config_body=CONFIG_FORMAT.format(ligand_path,ebox_guy[0])
    open(file_to_save, "w").write(config_body)

# from ChatGPT to rename the files from coconut#.pdbqt to config#.txt
# Get the list of files in the directory
files = os.listdir(CONFIG_FOLDER_PATH)

# Loop through the files
for file in files:
    # Check if the file name contains "pdbqt" or "coconut"
    if "pdbqt" in file or "coconut" in file:
        # Set the new file name
        new_file = file.replace("pdbqt", "txt").replace("coconut", "config")

        # Print the old and new file names
        print(f"{file} => {new_file}")

        # Rename the file (uncomment the following line to actually rename the file)
        os.rename(os.path.join(CONFIG_FOLDER_PATH, file), os.path.join(CONFIG_FOLDER_PATH, new_file))

