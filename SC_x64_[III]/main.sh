#!/bin/bash
# MAIN SZMELC-COMMANDER ENTRY POINT
# UPGRADED+++

clear && #cat README-64.md | lolcat
figlet SC-64 | lolcat -a -d 15 -s 69 -p 1 -F 0.1 
cat README-64.md | lolcat -a -d 15 -s 69 -p 1 -F 0.1
sleep 3s
clear && echo "" | lolcat
cat bin/cat/ASCII.md | lolcat
echo "" | lolcat
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | lolcat
echo "░░  SZMELC-COMMANDER-MAIN = ░░" | lolcat
echo "░░   == MK-VI ==  [rgf4y1]  ░░" | lolcat
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | lolcat
echo "" | lolcat
cat bin/cat/101.md | lolcat
echo ""
cat bin/cat/ASCIIS.md | lolcat
echo "" && echo ""

# Store the initial main directory
INITIAL_MAIN_DIR=$(pwd)

# LIST ONLY .sh FILES IN SC FOLDERS AS ENTRY POINTS FOR MULTI-PART UI SYSTEM

# Define the path to the 'SC' folder
SC_FOLDER="bin"

# Define the configuration file path
CONFIG_FILE="bin/config/bin-config.json"

# Define the special configuration file path
SPECIAL_CONFIG_FILE="bin/config/special.json"

# Read the special configuration file and extract the values
cgi_command=$(jq -r '.cgi_command' "$SPECIAL_CONFIG_FILE")
ascii_command=$(jq -r '.ascii_command' "$SPECIAL_CONFIG_FILE")

# Function to execute the selected .sh file
function execute_module() {
  selected_module="$1"
  bash "$selected_module" # Use the .sh file name and path during execution
}

# Play 1.wav if cgi_command is set to true in a new xterm window minimized on a separate thread
if [ "$matrix_command" == "true" ]; then
  xfce4-terminal -e 'echo eee'| 'cmatrix' | lolcat &
  #xterm -e 'cat bin/cat/boombox.md && while true; do ls bin/cgi/*.wav | shuf -n 1 | xargs play -q; done' &
 fi
if [ "$cgi_command" == "true" ]; then
  xterm -T "Music Player" -e 'cat bin/cat/boombox.md | lolcat & while true; do ls bin/cgi/*.wav | shuf -n 1 | xargs play -q; done' &
  wmctrl -r "Music Player" -b add,above,sticky
fi

# Read the configuration file and extract module names and file paths
module_list=()
while IFS= read -r line; do
  module_name=$(echo "$line" | jq -r '.name')
  module_file=$(echo "$line" | jq -r '.file')
  module_list+=("[$module_name] $module_file") # Use "file" value instead of "title"
done < <(jq -c '.modules[]' "$CONFIG_FILE")

# Use Zenity to create a list dialog with the module list
selected_module=$(zenity --list --title="SZMELC COMMANDER" --text="Select a module:" --column="Module" "${module_list[@]}" --height 400 --width 250)

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
  bash main.sh | lolcat
 fi
