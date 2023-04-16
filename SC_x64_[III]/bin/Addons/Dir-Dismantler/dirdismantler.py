import os
import shutil
import yaml

def load_config(config_file):
    with open(config_file, 'r') as f:
        config = yaml.safe_load(f)
    return config

def move_files(source_path, target_path, log_file):
    log_messages = []
    for root, dirs, files in os.walk(source_path):
        for file in files:
            file_path = os.path.join(root, file)
            target_file_path = os.path.join(target_path, file)
            if os.path.exists(target_file_path):
                # If file already exists, append a numerical suffix
                i = 1
                while True:
                    new_file_name = f"log-{i}.txt"
                    new_log_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'logs', new_file_name)
                    if not os.path.exists(new_log_file):
                        log_file = new_file_name
                        break
                    i += 1
            if not os.path.exists(target_path):
                os.makedirs(target_path)
            shutil.move(file_path, target_file_path)
            log_messages.append(f"Moved file: {file_path} -> {target_file_path}")

    return log_messages

def remove_empty_folders(source_path, log_file):
    log_messages = []
    for root, dirs, files in os.walk(source_path, topdown=False):
        for dir in dirs:
            dir_path = os.path.join(root, dir)
            if not os.listdir(dir_path):
                os.rmdir(dir_path)
                log_messages.append(f"Removed empty folder: {dir_path}")

    return log_messages

def log(log_messages, log_file):
    log_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'logs')
    if not os.path.exists(log_folder):
        os.makedirs(log_folder)
    log_file_path = os.path.join(log_folder, log_file)
    if os.path.exists(log_file_path):
        # If log file already exists, append a numerical suffix
        i = 1
        while True:
            new_file_name = f"log-{i}.txt"
            new_log_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'logs', new_file_name)
            if not os.path.exists(new_log_file):
                log_file = new_file_name
                break
            i += 1
    with open(os.path.join(log_folder, log_file), 'w') as f:
        f.write('\n'.join(log_messages) + '\n')
    print('Log file generated successfully:', os.path.join(log_folder, log_file))

if __name__ == '__main__':
    config_file = 'config.yml'
    config = load_config(config_file)
    source_path = config['source_path']
    target_path = config['target_path']

    if not os.path.exists(source_path):
        print(f"Source path '{source_path}' does not exist. Exiting...")
        exit(1)

    if not os.path.exists(target_path):
        print(f"Target path '{target_path}' does not exist. Creating directory...")
        os.makedirs(target_path)

    log_messages = move_files(source_path, target_path, 'log.txt')
    log_messages += remove_empty_folders(source_path, 'log.txt')

    log(log_messages, 'log.txt')
os.system('cls' if os.name == 'nt' else 'clear')
print('\n',' Files moved successfully!','\n',' Folder directories are no more','\n','\n',' SZMELC COMMANDER','\n')
