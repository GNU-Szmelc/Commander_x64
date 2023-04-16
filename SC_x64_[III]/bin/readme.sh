#!/bin/bash

# Store the initial main directory
INITIAL_MAIN_DIR=$(pwd)

# Function to display and execute the selected README file
display_readme() {
  echo "Displaying README: $1"
  # You can modify this function to display the contents of the selected README file
  # For example, you can use 'cat' command to display the contents
  cat "$1" | lolcat
}

# Change back to the initial main directory
cd "$INITIAL_MAIN_DIR"

# Recognize and list README.md files from the current path and its subdirectories
readme_files=($(find . -name "README.md"))
readme_list=()
for readme_file in "${readme_files[@]}"; do
  readme_list+=("$readme_file")
done

# Use Zenity to create a list dialog with the README list
selected_readme=$(zenity --list --title="README List" --text="Select a README file:" --column="README" "${readme_list[@]}" --height 400)

# Check if a README file is selected and call the function to display and execute it
if [ -n "$selected_readme" ]; then
  display_readme "$selected_readme"
else
  # If no README file is selected, change back to the initial main directory and exit the script
  cd "$INITIAL_MAIN_DIR"
  exit
fi
