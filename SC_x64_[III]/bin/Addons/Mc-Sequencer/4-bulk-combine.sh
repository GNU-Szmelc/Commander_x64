#!/bin/bash

# Navigate to Sorted/Function directory
cd Sorted || exit

# Create Processed directory if it doesn't exist
mkdir -p ../Processed

# Combine contents of .mcfunction files into dump.mcfunction
find . -name "*.mcfunction" -type f -exec cat {} + > ../Processed/dump.mcfunction

echo "Combined all .mcfunction files into Sorted/Processed/dump.mcfunction"
