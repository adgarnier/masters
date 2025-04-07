## Ligand Docking and File Processing Scripts

This repository contains scripts used for ligand file preparation, docking job automation, file organization, and output parsing. 
These tools are useful for handling large-scale virtual screening workflows.

---

📁 Script Overview

| Script | Inputs | Outputs | Dependency | Function |
|--------|--------|---------|------------|----------|
| `andy_upgraded.py` | `config files.txt` | `CONFIG_FORMAT.txt` | — | Sets paths in config files |
| `eboxsize.pl` | — | — | — | Prepares config files with specific ligand |
| `combine_directories.py` | Directory 1, Directory 2, Output Directory | Combined directory | — | Combines contents of two directories |
| `count_affinities_decimal_upgraded_2.sh` | Directory with Vina log files | `affinity_counts.txt` | — | Extracts and counts binding affinities |
| `counting_logs_in_subdirs.sh` | Path, Number of subdirectories | Zipped directory | — | Unzips logs, moves files, and counts them |
| `file_combine_and_sort.py` | Files to combine, Output name | Combined and sorted file | — | Combines and sorts files from low to high |
| `file_splitting.py` | Input file | Split files | — | Splits a file into 4 equal parts |
| `find_common_to_all_files.py` | Sets | Terminal output | — | Finds values common to all sets |
| `identify_affinities_files_upgraded.sh` | Directory name, Number of subdirectories | `affinity_file_names.txt` | — | Lists ligands and their affinities |
| `isolate_candidates.sh` | Directory name | `candidates/` | `unzip_zips.py` | Extracts files from defined ligand list |
| `isolate_coconut_id.py` | Directory name, List of indices | Terminal output | — | Retrieves Coconut ID (CNP) from `.sdf` files |
| `isolate_coconut_name.py` | Directory name, List of indices | Terminal output | — | Retrieves Coconut filenames from `.sdf` files |
| `isolate_logs.sh` | Ligand list, Number of subdirectories | `candidates/` | — | Moves selected log files to target directory |
| `isolate_pdbqts.sh` | Ligand list, Number of subdirectories | `candidates/` | — | Moves selected `.pdbqt` files to target directory |
| `jobscript_subdir_prep.sh` | Jobscript name, Directory name, Number of subdirectories | Multiple job scripts | — | Splits jobscript per ligand subdirectory |
| `make_subdir.sh` | Directory, Files per subdir | Subdirectories | — | Splits a directory into smaller subdirectories |
| `mv_subdir_jobscript.sh` | Base path, Index number | Flattened files | — | Moves files out of subdirectories |
| `rename_script.py` | Directory | Renamed files | — | Renames `3d_hydrated_coconut*` to `coconut*` |
| `sdf_to_pdbqt_converter_upgraded.sh` | — | `.pdbqt` files | `mk_prepare_ligand.py` | Converts `.sdf` files to `.pdbqt` |
| `shuttle_3digits.py` | Source dir, Destination dir | Filtered ligands | — | Moves ligands sized 100–1000 kDa |
| `shuttle_names.py` | Source dir, Destination dir | Filtered ligands | — | Moves ligands whose names start with a letter |
| `shuttle_trashing.py` | Source dir, Destination dir, Search term | Filtered ligands | — | Moves undesired ligands |
| `submit_script.sh` | Directory name, Number of job scripts | — | — | Submits all prepared jobscripts |
| `subdir_zipping.py` | Directory name, Output directory | Zipped subdirectories | — | Zips all subdirectories of a directory |
| `unzip_tars.py` | — | Unzipped tar files | — | Unzips all `.tar` files in working directory |
| `unzip_zips.py` | Directory | Unzipped zip files | — | Unzips all `.zip` files in a directory |
| `vf_compare_qvina_smina_results.py` | `qvina.txt`, `smina.txt`, `output.txt` | `output.txt` | — | Compares qvina and smina results |
| `vf_firstposes_sorter.py` | Input file | `output.txt` | — | Sorts Vina results from low to high |
| `vf_tranches_and_ligands.py` | Input file, Output file | `output.txt` | — | Extracts tranches and ligand names |
| `vina_upgraded.sh` | Paths | Logs, Outputs | — | Runs AutoDock Vina using templates |
| `zip_files_count.py` | Directory | Terminal output | — | Counts files inside `.zip` archives |

---

🔧 Notes

- Ensure required dependencies such as AutoDock Vina, Python 3, and Perl are installed.
- Scripts marked with "other" or reused (e.g., `eboxsize.pl`, `mk_prepare_ligand.py`) may exist in multiple folders.
- Most file operations assume a specific directory structure; modify paths as needed for your workflow.

---

🧪 Example Use Cases

- **Prepare ligands**: Convert `.sdf` files to `.pdbqt` using `sdf_to_pdbqt_converter_upgraded.sh`.
- **Run docking jobs**: Use `vina_upgraded.sh` with config files and ligands.
- **Process outputs**: Use `vf_firstposes_sorter.py` to rank ligand affinities.
- **Manage data**: Combine, filter, and isolate files with the various `shuttle_*.py` and `isolate_*.sh` scripts.
