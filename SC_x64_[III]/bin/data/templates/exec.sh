#!/bin/bash

# Define the path to the 'Addons' folder
ADDONS_FOLDER="$(dirname "$0")"

# Function to execute the selected .sh file
function execute_panel() {
  selected_panel="$1"
  cd "$(dirname "$selected_panel")"
  bash "$(basename "$selected_panel")"
}

# Generate panel list based on .sh files in Addons folder
panel_list=()
IFS=$'\n'
for file in $(find "$ADDONS_FOLDER" -type f -name "*.sh"); do
  panel_folder=$(dirname "$file")
  panel_name=$(basename "$file")
  panel_list+=("[$(basename "$panel_folder")] $panel_name")
done
unset IFS

# If no panels are found, display an error message
if [ ${#panel_list[@]} -eq 0 ]; then
  zenity --error --text="No panel files found in Addons folder!"
  exit 1
fi

# Use Zenity to create a list dialog with the panel list
selected_panel=$(zenity --list --title="Panel List" --text="Select a panel:" --column="Panel" "${panel_list[@]}" --height 400)

# Check if a panel is selected and call the function to execute it
if [ -n "$selected_panel" ]; then
  panel_name=$(echo "$selected_panel" | sed -E 's/\[([^]]+)\].*/\1/')
  panel_file=$(echo "$selected_panel" | sed -E 's/.*\] (.*)/\1/')
  execute_panel "$ADDONS_FOLDER/$panel_name/$panel_file"
fi
