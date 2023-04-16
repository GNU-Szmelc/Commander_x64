#!/bin/bash

# Get the directory where the script is located
script_dir=$(dirname "$0")

# Load the config file into a Bash variable
config=$(jq -r '.' "$script_dir/config.json")

# Load the data from the config.yml file
m_name=$(echo "$config" | jq -r '.main.name')
m_repo=$(echo "$config" | jq -r '.main.repo')


# Check for empty variables
if [[ -z "$m_name" || -z "$m_repo" ]]; then
  echo "Error: Main name and/or main repo not found in config.yml"
  exit 1
fi

# Obsidian CLI Szmelc.INC - GitHub Force Sync [Remote -> Local] [R2L]

REMOTE="git@github.com:$m_name/$m_repo"
LOCAL="./$m_repo" # Will create same folder name as repository

echo $REMOTE
# Initialize directory
if [ ! -d .git ]; then
  git init
fi

# Purge local Obsidian directory, clone remote, remove .git folder.
rm -fr "$LOCAL"
git clone "$REMOTE"
rm -fr "./$m_repo/.git"
