#!/bin/bash
# Default exec.sh main entrypoint
# Verify szmelc integrity, initialize main.py (or any other language script)
# Curl manual & Add based loading bar

# Script Dir
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
MAIN_DIR="$SCRIPT_DIR/main.py"

sleep 1 && echo "" && echo " ~ Initializing: [${SCRIPT_DIR##*/}] ~ " && echo ""

# Totally legit loading bar
sleep 1 && echo "" && sleep 1 && echo " ~ Starting Command Line Interface ~ " && sleep 1 && echo " ~ (Python3)-(CLI)-(main.py) ~ " && sleep 2 && clear && sleep 1 && echo "" && echo "      [=== LOADING ===]" && echo "" && echo -ne '[#]\r' && sleep 0.2 && echo -ne '[##]\r' && sleep 0.2 && echo -ne '[###]\r' && sleep 0.2 && echo -ne '      [####]\r' && sleep 0.2 && echo -ne '      [#####]\r' && sleep 0.2 && echo -ne '      [######]\r' && sleep 0.2 && echo -ne '      [#######]\r' && sleep 0.2 && echo -ne '      [########]\r' && sleep 0.2 && echo -ne '      [#########]\r' && sleep 0.2 && echo -ne '      [##########]\r' && sleep 0.2 && echo -ne '      [###########]\r' && sleep 0.2 && echo -ne '      [############]\r' && sleep 0.2 && echo -ne '      [#############]\r' && sleep 0.2 && echo -ne '      [##############]\r' && sleep 0.2 && echo -ne '      [###############]\r' && sleep 0.2 && echo -ne '      [###############]\r' && sleep 0.2 && sleep 1 && clear && sleep 1

# Insert raw paste URL for Readme / Man page
echo " ~ [Manual page from pastebin:] ~ " && sleep 1
curl "https://pastebin.com/raw/2nY0ueHz"

# Execute main.py inside spawned terminal emulator for CLI panel
# Fix all dependencies here

python3 ${MAIN_DIR}
