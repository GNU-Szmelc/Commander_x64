#!/bin/bash
# [Get Addons]

# Set the default download directory and target directory
download_dir="tmp"
target_dir="Addons"

# Load repositories from repos.json file
repositories=($(jq -r '.[]' config/repos.json))

# Create the target directory if it doesn't exist
mkdir -p "$target_dir"

# Use Zenity to display a UI for selecting repository names
selected_repo=$(zenity --list \
                      --title="Select Repository" \
                      --column="Repository" "${repositories[@]##*/}")

# Check if a repository was selected
if [[ -n "$selected_repo" ]]; then
    # Clone the selected repository into the target directory
    cd "$target_dir"
    git clone "https://github.com/Shmelc-sh/$selected_repo"
    
    # Print success message
    echo "Successfully cloned repository $selected_repo into $target_dir"
else
    # Print error message
    echo "No repository selected. Exiting."
fi
