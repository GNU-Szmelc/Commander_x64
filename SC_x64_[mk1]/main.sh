#!/bin/bash
# MAIN SZMELC-COMMANDER ENTRY POINT w ASCII

clear && echo ""
cat cat/ASCII.md 
echo "" 
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
echo "░░  SZMELC-COMMANDER-MAIN = ░░"
echo "░░   == MK-VI ==  [rgf4y1]  ░░"
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
echo ""
cat cat/101.md
echo ""
cat cat/ASCIIS.md
echo "" && echo ""
# Store the initial main directory
INITIAL_MAIN_DIR=$(pwd)

# LIST ONLY .sh FILES IN SC FOLDERS AS ENTRY POINTS FOR MULTI-PART UI SYSTEM

# Define the path to the 'SC' folder
SC_FOLDER="bin"

# Define the configuration file path
CONFIG_FILE="bin/config/bin-config.json"

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

# Use Zenity to create a list dialog with the module list
selected_module=$(zenity --list --title="SZMELC COMMANDER" --text="Select a module:" --column="Module" "${module_list[@]}" --height 400 --width 350)

# Check if a module is selected and call the function to execute it
if [ -n "$selected_module" ]; then
  module_name=$(echo "$selected_module" | sed -E 's/\[([^]]+)\].*/\1/')
  module_file=$(echo "$selected_module" | sed -E 's/.*\] (.*)/\1/')
  cd "$SC_FOLDER" # Change to SC directory
  execute_module "$module_file" # Use the "file" value from config.json as the .sh file name during execution
else
  # Change back to the initial main directory and run main.sh
  cd "$INITIAL_MAIN_DIR"
  clear
  bash main.sh
fi
