#!/bin/bash

# Define the path to the 'Addons' folder
ADDONS_FOLDER="./Addons"

# Function to execute the selected .sh or .py file
function execute_module() {
  selected_module="$1"
  module_folder=$(dirname "$selected_module")
  module_name=$(basename "$module_folder")
  module_file=$(basename "$selected_module")
  cd "$module_folder"
  if [[ "$module_file" == *.sh ]]; then
    bash "$module_file"
  elif [[ "$module_file" == *.py ]]; then
    python3 "$module_file"
  else
    zenity --error --text="Invalid file type!"
    exit 1
  fi
}

# Generate module list based on .sh and .py files in Addons folder
module_list=()
IFS=$'\n'
for file in $(find "$ADDONS_FOLDER" -type f \( -name "*.sh" -o -name "*.py" \)); do
  module_folder=$(dirname "$file")
  module_name=$(basename "$file")
  module_list+=("[$(basename "$module_folder")] $module_name")
done
unset IFS

# If no modules are found, display an error message
if [ ${#module_list[@]} -eq 0 ]; then
  zenity --error --text="No module files found in Addons folder!"
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
