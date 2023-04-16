import os
import shutil
import yaml

# Load configuration from config.yml file
config_path = os.path.join(os.path.dirname(__file__), 'config.yml')
with open(config_path, 'r') as config_file:
    config = yaml.safe_load(config_file)

# Get source directories from config
source_dirs = config.get('source_directories')
if not source_dirs:
    print("Source directories not specified in config.yml.")
    exit(1)

# Get excluded directories from config
excluded_dirs = config.get('excluded_directories', [])
if not excluded_dirs:
    print("Excluded directories not specified in config.yml.")
    exit(1)

# Create target directories if they don't exist
for file_format, target_dir in config.items():
    if file_format not in ['source_directories', 'special_rules', 'excluded_directories'] and isinstance(target_dir, str):
        target_path = os.path.join(os.path.dirname(__file__), target_dir)
        if not os.path.exists(target_path):
            os.makedirs(target_path)

# Helper function to resolve naming conflicts
def resolve_conflict(target_path):
    """
    Resolves naming conflicts by adding a numbering scheme to the target file.
    """
    base_name, file_format = os.path.splitext(target_path)
    counter = 1
    while os.path.exists(target_path):
        target_path = f"{base_name}-{counter}{file_format}"
        counter += 1
    return target_path

# Log recent activity
log = []

# Supported file formats and target directories from config
supported_formats = config.get('formats', [])
target_dirs = config

# Function to search for files in directory and its subdirectories
def search_files(directory):
    # Skip processing directory if it's excluded
    if directory in excluded_dirs:
        log.append(f"Skipping excluded directory: {directory}")
        return

    for dirpath, dirnames, filenames in os.walk(directory):
        # Exclude excluded directories
        dirnames[:] = [d for d in dirnames if d not in excluded_dirs]
        for filename in filenames:
            file_path = os.path.join(dirpath, filename)
            file_format = os.path.splitext(filename)[1]
            if file_format in supported_formats:
                target_dir = target_dirs.get(file_format)
                if target_dir is not None and isinstance(target_dir, str):
                    target_path = os.path.join(os.path.dirname(__file__), target_dir, filename)
                    if os.path.exists(target_path):
                        target_path = resolve_conflict(target_path)
                        log.append(f"Resolved naming conflict: {filename} -> {target_path}")
                    shutil.move(file_path, target_path)
                    log.append(f"Moved {filename} to {target_path}")
                else:
                    for rule in config.get('special_rules', []):
                        if file_format == rule[0] and rule[1] in dirpath:
                            target_path = os.path.join(os.path.dirname(__file__), rule[2], filename)
                            if os.path.exists(target_path):
                                target_path = resolve_conflict(target_path)
                                log.append(f"Resolved naming conflict: {filename} -> {target_path}")
                            shutil.move(file_path, target_path)
                            log.append(f"Moved {filename} to {target_path}")
                            break
                    else:
                        log.append(f"No target directory specified for file format: {file_format}")
            else:
                log.append(f"Ignored {filename} (unsupported file format)")

# Search for files in all source directories and their subdirectories
for source_dir in source_dirs:
    if os.path.exists(source_dir):
        log.append(f"Searching for files in directory: {source_dir}")
        search_files(source_dir)
        log.append(f"Finished searching for files in directory: {source_dir}")
    else:
        log.append(f"Source directory not found: {source_dir}")

# Delete empty directories inside source directories
for source_dir in source_dirs:
    for dirpath, dirnames, filenames in os.walk(source_dir, topdown=True):
        for dirname in dirnames:
            dir_path = os.path.join(dirpath, dirname)
            if not os.listdir(dir_path):
                os.rmdir(dir_path)
                log.append(f"Deleted empty directory: {dir_path}")

# Create logs folder if it doesn't exist
logs_dir = os.path.join(os.path.dirname(__file__), 'logs')
if not os.path.exists(logs_dir):
    os.makedirs(logs_dir)

# Create new log file with unique name
log_file_path = os.path.join(logs_dir, 'log-1.txt')
counter = 1
while os.path.exists(log_file_path):
    counter += 1
    log_file_path = os.path.join(logs_dir, f'log-{counter}.txt')
    
# Save log to log file
with open(log_file_path, 'w') as log_file:
    log_file.write('\n'.join(log))

os.system('cls' if os.name == 'nt' else 'clear')
print('\n'," Operation Complete",'\n'," Runtime log saved in logs directory",'\n','\n'," SZMELC.INC - SilverX",'\n')
