# [Szmelc-Organizer]
## Simple file sorter & organizer written in Python3 [CLI]

<img src="https://i.imgur.com/kbGY8cK.png" alt="image" width="640" height="320">

> Addon for [SZMELC COMMANDER]

### FILES
> `sorter.py` - Main sorting script\
> `config.yml` - YAML config file (specify file extensions / source & target paths)\

### MISC
Default configuration will create `Sorted` folder tree inside script's directory\
Save output logs as `log-*.txt` in `logs` folder\
Delete all remaining empty folders\
For now, all incompatible files without `.format`, without name but with `format` or `.format` will remain as is.\
To add your own file formats / extensions, include them into `config.yml`
