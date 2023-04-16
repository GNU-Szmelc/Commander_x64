# SZMELC RUNNER MKII
# Package runner for Szmelc Commander
# List & Execute every 'exec.sh' file found within 'packages' dir subdirectories

import os
import time

# Define the root directory to search
root_dir = './packages'

# Initialize a list to store the paths of all found exec.sh files
exec_paths = []

# Recursively search for exec.sh file in root_dir
for dirpath, dirnames, filenames in os.walk(root_dir):
    if 'exec.sh' in filenames:
        # If exec.sh is found, append the path to the exec_paths list
        exec_path = os.path.join(dirpath, 'exec.sh')
        exec_paths.append(exec_path)

# Display a selection list menu of all found exec.sh files
os.system(f'clear')
print("===========================")
print("===== [SZMELC RUNNER] =====")
print("===========================")
print("")

# Define available options
print("\n== FOUND PACKAGES [exec.sh] ==")
print("====== ====== ====== ======")
for i, exec_path in enumerate(exec_paths):
    # Use the directory name as the selection name
    selection_name = os.path.basename(os.path.dirname(exec_path))
    print(f'{i+3}. {selection_name}')
    
print("\n== OPTIONS ==")
print("1. Szmelc Commander [Main]")


# Get user input for the selected file
selection = input('\nSelect option to execute: ')
selection_index = int(selection)

# Execute the selected option
if selection_index == 1:
    # Execute Szmelc Commander script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    szmelc_commander_path = os.path.join(script_dir, 'main.py')
    os.system(f'python3 "{szmelc_commander_path}"')
elif selection_index >= 3 and selection_index < len(exec_paths) + 3:
    # Make the selected exec.sh file executable
    selected_exec_path = exec_paths[selection_index - 3]
    os.system(f'chmod +x "{selected_exec_path}"')

    # Execute the selected file in a new xterm window in 50x25 resolution
    os.system(f'xterm -fa "Monospace" -fs 10 -geometry 50x25 -e "bash -c \\"bash {selected_exec_path}; exec bash\\""')
else:
    print("Invalid selection. Exiting Szmelc Runner...")
