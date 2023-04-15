#!/bin/bash
# [Get Addons]

# Set the default download directory and target directory
download_dir="tmp"
target_dir="Addons"

# Load repositories from repos.json file
repositories=($(jq -r '.[]' config/repos.json))

# Create the target directory if it doesn't exist
mkdir -p "$target_dir"

# Loop through each repository and perform git clone/update
for repo_url in "${repositories[@]}"; do
    # Extract the repository name from the URL
    repo_name=$(basename "$repo_url")

    # Check if the repository already exists in the target directory
    if [ -d "$target_dir/$repo_name" ]; then
        # If it does, forcefully remove it
        rm -rf "$target_dir/$repo_name"
    fi

    # Clone the repository into the target directory, forcefully skipping username/password prompts
    GIT_TERMINAL_PROMPT=0 git clone "$repo_url" "$target_dir/$repo_name"

    # Print success message
    echo "Successfully cloned/update repository $repo_name into $target_dir"
done

# Print completion message
echo "Cloning/Updating of repositories from repos.json completed."
