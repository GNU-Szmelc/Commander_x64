#!/bin/bash
# [Run Addons]

# LIST ONLY `exec.sh` FILES IN ADDONS DIR AS ENTRY POINTS FOR MULTI-PART UI SYSTEM

# Define the path to the 'Addons' folder
ADDONS_FOLDER="./Addons"

# Function to execute the selected .sh file
function execute_module() {
  selected_module="$1"
  bash "$selected_module"
}

# Generate module list based on exec.sh files in Addons folder
module_list=()
IFS=$'\n'
for file in $(find "$ADDONS_FOLDER" -type f -name "exec.sh"); do
  module_folder=$(dirname "$file")
  module_name=$(basename "$module_folder")
  module_file=$(basename "$file")
  module_list+=("[$module_name] $module_file")
done
unset IFS

# If no modules are found, display an error message
if [ ${#module_list[@]} -eq 0 ]; then
  zenity --error --text="No 'exec.sh' files found in Addons folder!"
  exit 1
fi

# Use Zenity to create a list dialog with the module list
selected_module=$(zenity --list --title="Module List" --text="Select a module:" --column="Module" "${module_list[@]}" --height 400)

# Check if a module is selected and call the function to execute it
if [ -n "$selected_module" ]; then
  module_name=$(echo "$selected_module" | sed -E 's/\[([^]]+)\].*/\1/')
  module_file=$(echo "$selected_module" | sed -E 's/.*\] (.*)/\1/')
  execute_module "$ADDONS_FOLDER/$module_name/$module_file"
fi
