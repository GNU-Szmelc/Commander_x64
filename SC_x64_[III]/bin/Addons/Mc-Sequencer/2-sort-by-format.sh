#!/bin/bash

# Set default source and destination directories
SOURCE_DIR="Target"
DESTINATION_DIR="Sorted"

# Loop through each file in the source directory and its subdirectories
find "$SOURCE_DIR" -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Get the file format by extracting the file extension
    file_extension="${file##*.}"
    
    # Ignore files with names that contain '.' followed by '_'
    if [[ ! "$file_extension" =~ \._ ]]; then
        # Create the subdirectory based on the file format, if not already exists
        subdirectory="$DESTINATION_DIR/$file_extension"
        
        # Ignore creating subdirectories with '_' in their names
        if [[ ! "$subdirectory" =~ _ ]]; then
            mkdir -p "$subdirectory"
            
            # Move the file into the corresponding subdirectory using force
            mv -f "$file" "$subdirectory/"
            echo "Moved $file to $subdirectory/"
        fi
    else
        # Check if the file is an archive by checking its true format metadata
        file_format="$(file -b --mime-type "$file")"
        if [[ "$file_format" =~ ^application/x-tar$|^application/x-gzip$|^application/zip$ ]]; then
            # Create the "RE" folder if not already exists
            re_directory="$DESTINATION_DIR/RE"
            mkdir -p "$re_directory"
            
            # Extract the archive into the "RE" folder, ignoring all errors and using force
            tar -xzf "$file" -C "$re_directory" 2>/dev/null
            unzip -q "$file" -d "$re_directory" 2>/dev/null
            echo "Extracted $file into $re_directory/"
            
            # Remove the extracted archive file
            rm -f "$file"
            echo "Removed $file"
        fi
    fi
done

# Remove all remaining contents of the "Target" folder
rm -rf "$SOURCE_DIR"/*
echo "Removed all remaining contents of $SOURCE_DIR"
