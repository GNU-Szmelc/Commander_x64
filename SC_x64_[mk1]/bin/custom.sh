#!/bin/bash
# SIMPLE CUSTOM UI

# LIST ONLY .sh FILES IN `Misc` FOLDER AS ENTRY POINTS FOR MULTI-PART UI SYSTEM

# Define the path to the 'Misc' folder
SC_FOLDER="Custom"

# Define the configuration file path
CONFIG_FILE="config/custom-config.json"

# Function to execute the selected .sh file
function execute_module() {
  selected_module="$1"
  bash "$selected_module" # Use the .sh file name and path during execution
}

# Read the configuration file and extract module names and file paths
module_list=()
while IFS= read -r line; do
  module_name=$(echo "$line" | jq -r '.name')
  module_file=$(echo "$line" | jq -r '.file')
  module_list+=("[$module_name] $module_file") # Use "file" value instead of "title"
done < <(jq -c '.modules[]' "$CONFIG_FILE")

# If no modules are found in the configuration file, display an error message
if [ ${#module_list[@]} -eq 0 ]; then
  zenity --error --text="No modules found in the configuration file!"
  exit 1
fi

# Use Zenity to create a list dialog with the module list
selected_module=$(zenity --list --title="Module List" --text="Select a module:" --column="Module" "${module_list[@]}" --height 400)
cd "$SC_FOLDER"
# Check if a module is selected and call the function to execute it
if [ -n "$selected_module" ]; then
  module_name=$(echo "$selected_module" | sed -E 's/\[([^]]+)\].*/\1/')
  module_file=$(echo "$selected_module" | sed -E 's/.*\] (.*)/\1/')
  cd Misc # Change to SC directory
  execute_module "$module_file" # Use the "file" value from config.json as the .sh file name during execution
fi
