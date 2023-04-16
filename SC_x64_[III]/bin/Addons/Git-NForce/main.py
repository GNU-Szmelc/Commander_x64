import subprocess
import os
import threading
import time
import shlex
import sys

# Obsidian Manager API v1 - .py script to manage .sh scripts
# Define the available options

# cd into own dir
script_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
os.chdir(script_dir)

# Fancy CLI

print('Initialization...')
subprocess.Popen('clear', shell=True),'\n',time.sleep(0.5)
print("░════░════░════░════░════░"),'\n',print("░ MAKE SURE TO CONFIGURE ░"),'\n',print("░ USER VARIABLES IN config.json ░"),'\n',print("░ BEFORE PROCEEDING      ░"),'\n',print("░════░════░════░════░════░"),'\n',print("")

print('░░░░░░░░░░░░░░░░░░░░░░░░░░')
print("░█▀ █░█ █▀▄▀█ █▀▀ █░░ █▀▀░")
print("░▄█ █▀█ █░▀░█ ██▄ █▄▄ █▄▄░")
print('░░░░░░░░░░░░░░░░░░░░░░░░░░')
print("░════░════░════░════░════░")
print('░░░░░░░░░░░░░░░░░░░░░░░░░░')
print('░░ Git-NForce Interface ░░')
print('░░░░░░░░░░░░░░░░░░░░░░░░░░')

# Super shitty way to format variables but well, it works so there you go.
options = ['░░ Post Local [L2R]  ░░', '░░ Clone Remote [R2L]░░', '░░ Cancel [Q]        ░░']

# Display the options to the user
print('~! ░░ [Select an option] ░'),'\n',print('░░░░░░░░░░░░░░░░░░░░░░░░░░')

for i, option in enumerate(options):
    print(f'{i+1}. {option}')
print('░░░░░░░░░░░░░░░░░░░░░░░░░░')

# Ask the user to select an option
selected_option = input('[x]░░ Select action: ~')

# Check if the selected option is valid
if selected_option.isdigit() and 1 <= int(selected_option) <= len(options):
    selected_option = int(selected_option)
else:
    print('Invalid selection. Adios.')
    exit()
print('░░░░░░░░░░░░░░░░░░░░░░░░░░')

# Execute the selected script in a new terminal window
if selected_option == 1:
    subprocess.Popen('bash FSL2R.sh', shell=True)
elif selected_option == 2:
    subprocess.Popen('bash FSR2L.sh', shell=True)
else:
    print('Operation canceled.')

