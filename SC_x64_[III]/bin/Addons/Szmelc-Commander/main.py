# SZMELC COMMANDER MKII
# Main / Manager module

import os
import shutil
import subprocess
import time
import yaml

with open("config.yml", "r") as f:
    config = yaml.safe_load(f)

# Access the config.yml configuration data
main = config["main"]
var1 = main["var1"]
var2 = main["var2"]
var3 = main["var3"]
var4 = main["var4"]

# Define the repositories to download
repositories = [
    "https://github.com/serainox420/Minecraft-Server-Silverscanner",
    "https://github.com/serainox420/Craft-Net",
    "https://github.com/serainox420/Git-NForce",
    "https://github.com/serainox420.github.io",
    "https://github.com/serainox420/InstallShell"
]

# Define the download directory
download_dir = "packages"

script_dir = os.path.dirname(os.path.abspath(__file__))

# Define the remove directory
remove_dir = ".git"

# Clear terminal
os.system("clear")

# Create the download directory if it doesn't exist
if not os.path.exists(download_dir):
    os.mkdir(download_dir)
# Welcome print
print("===============================================")
print("============ [SZMELC COMMANDER] ===============")
print("===============================================\n")
print("===  [Select package to install / update:]  ===")
print("===============================================")
print("\n=== PACKAGES ==="),
for i, repo in enumerate(repositories):
    repo_name = repo.split("/")[-1].split(".")[0]
    print(f"{i+1}. {repo_name}")
# Print Options
print("\n=== OPTIONS ===")
print(f"{len(repositories)+1}. Szmelc Commander [Runner]")    
print(f"{len(repositories)+2}. List packages")
print(f"{len(repositories)+3}. Config.yml")
print(f"{len(repositories)+4}. Manual")
print(f"{len(repositories)+5}. Exit\n")

	 		
while True:
    try:
        # Prompt the user for a selection
        selection = input(f"Enter a number between 1 and {len(repositories)+5}: ")

        # Check if the selection is valid
        if not selection.isdigit() or int(selection) < 1 or int(selection) > len(repositories)+5:
            raise ValueError("Invalid selection")
            
        # List installed packages (packages dir contents)
        cmd1 = 'ls -l | awk \'{print " ["$9"]", "- ["$6,$7"]"}\''
        cmd = 'cd packages && ' + cmd1
        if int(selection) == len(repositories)+2:
            print("\n=========\nInstalled packages\n=========\n")
            subprocess.run(cmd, shell=True)
            print("\n=========\n")
            continue
            
        # Open config.yml file
        if int(selection) == len(repositories)+3:    
            os.system(f"open {os.path.join(script_dir, 'config.yml')}")
            break
            
        # Show Manual from pastebin 
        if int(selection) == len(repositories)+4:    
            os.system("curl https://pastebin.com/raw/2nY0ueHz")
            break
            
        # Run script from runner.py file
        if int(selection) == len(repositories)+1:
            os.system(f"python3 {os.path.join(script_dir, 'runner.py')}")
            break
            
        # Exit if the selection is the last option
        if int(selection) == len(repositories)+5:
            break     
	               
        # Download and unpack the repository
        repo_url = repositories[int(selection)-1]
        repo_name = os.path.basename(repo_url).split(".")[0]
        repo_dir = os.path.join(download_dir, repo_name)
        if os.path.exists(repo_dir) and os.path.isdir(repo_dir) and os.listdir(repo_dir):
            confirm_overwrite = input(f"\n[{repo_dir}] Already exists. Overwrite? (y/n): ")
            if confirm_overwrite.lower() != "y":
                continue
            shutil.rmtree(repo_dir)
        os.chdir(download_dir)
        time.sleep(1),os.system(f"clear"),time.sleep(1)
        os.system(f"git clone {repo_url}")
        os.chdir(repo_name)
        shutil.rmtree(remove_dir, ignore_errors=True)
        os.chdir(script_dir)
        print("\n   ~ SUCCESS ~   \n"),time.sleep(1),print("   ~ MAIN MENU [3s] ~   \n"),time.sleep(3)

        # Exit the loop and restart the main script
		# Restart main script
        os.system(f"python3 {__file__}")
        break
		
		
    except ValueError as e:
        print(str(e))
