#!/bin/bash

# Source and Target folders
SOURCE_FOLDER="Source"
TARGET_FOLDER="Target"

# Function to handle renaming of extracted files
rename_file() {
  local target_file="$1"
  local num=1
  local new_file="${target_file}"
  while [[ -e "${TARGET_FOLDER}/${new_file}" ]]; do
    new_file="${target_file%.*}_${num}.${target_file##*.}"
    ((num++))
  done
  echo "${new_file}"
}

# Check if Source folder exists
if [[ ! -d "${SOURCE_FOLDER}" ]]; then
  echo "Source folder does not exist!"
  exit 1
fi

# Check if Target folder exists, create if not
if [[ ! -d "${TARGET_FOLDER}" ]]; then
  mkdir "${TARGET_FOLDER}"
fi

# Extract all .zip files from Source folder to Target folder
for zip_file in "${SOURCE_FOLDER}"/*.zip; do
  unzip -o "${zip_file}" -d "${TARGET_FOLDER}" 2>/dev/null || true
  extracted_files=( "${TARGET_FOLDER}"/* )
  for extracted_file in "${extracted_files[@]}"; do
    mv -n "${extracted_file}" "${TARGET_FOLDER}/$(rename_file $(basename "${extracted_file}"))"
  done
done

echo "Extraction completed successfully!"
