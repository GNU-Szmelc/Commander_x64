#!/bin/bash

# Directory to archive
SOURCE_DIR="./Sorted"
# Directory to store archived files
ARCHIVE_DIR="./Archived"
# Extension for archived files
ARCHIVE_EXTENSION=".tar.gz"

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Loop through each directory inside SOURCE_DIR
for dir in "$SOURCE_DIR"/*; do
  # Check if it's a directory
  if [ -d "$dir" ]; then
    # Extract directory name
    dir_name=$(basename "$dir")
    # Create archive filename
    archive_filename="$dir_name$ARCHIVE_EXTENSION"
    # Create archive
    tar -czf "$ARCHIVE_DIR/$archive_filename" -C "$SOURCE_DIR" "$dir_name"
    echo "Archived $dir_name to $ARCHIVE_DIR/$archive_filename"
  fi
done

echo "All folders inside $SOURCE_DIR are archived and saved in $ARCHIVE_DIR."
