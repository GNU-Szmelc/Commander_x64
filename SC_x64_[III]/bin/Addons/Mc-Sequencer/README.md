# MC-Sequencer

## `1-unzip-all.sh`
> Extract all resource / data packs (.zip) from "Source" to "Target"
## `2-sort-by-format.sh`
> Sort all non folder files from "Target" to "Sorted" -> "<file_format_folder_name>"
## `3-archive-raw.sh`
> Archive all sorted by format folders from "Sorted" directory to `tar.gz` to save space, save in "Archived" directory
## `4-bulk-combine.sh`
> Combine all `.mcfunction` files into one big `dump.mcfunction` in "Processed" folder
