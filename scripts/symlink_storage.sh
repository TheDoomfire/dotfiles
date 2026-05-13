#!/bin/bash

# SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# HDD_PATH="/mnt/SILO"
HDD_PATH="/mnt/movies_games"
STORAGE_PATH="$HDD_PATH/data/"
# INPUT_FILE="$SCRIPT_DIR/storage_path.txt"
# INPUT_FILE="$SCRIPT_DIR/storage_paths.txt"

# TODO: Make this being a level up from the script. So it't at the root?
# - Seperated by a pipe (|)
INPUT_FILE="storage_paths.txt"

# Check if the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: $INPUT_FILE not found."
    exit 1
fi

# Create the symlinks

# while IFS='|' read -r src dest; do
#     [[ -z "$src" || -z "$dest" ]] && continue
#
#     FULL_SRC="${STORAGE_PATH}${src}"
#     FULL_DEST="${HOME}${dest}"
#
#     # Handle existing destination
#     if [[ -d "$FULL_DEST" && ! -L "$FULL_DEST" ]]; then
#         echo "Removing existing directory: $FULL_DEST"
#         rm -rf "$FULL_DEST"
#     elif [[ -L "$FULL_DEST" ]]; then
#         echo "Removing existing symlink: $FULL_DEST"
#         rm "$FULL_DEST"
#     fi
#
#     # Ensure the parent directory of the destination exists
#     mkdir -p "$(dirname "$FULL_DEST")"
#
#     echo "Linking: $FULL_SRC -> $FULL_DEST"
#     ln -sfn "$FULL_SRC" "$FULL_DEST"
#
# done < "$INPUT_FILE"


# REMOVE ALL SYMLINKS :

while IFS='|' read -r src dest; do
    [[ -z "$src" || -z "$dest" ]] && continue
    
    FULL_DEST="${HOME}${dest}"

    if [[ -L "$FULL_DEST" ]]; then
        echo "Removing symlink: $FULL_DEST"
        rm "$FULL_DEST"
    elif [[ -e "$FULL_DEST" ]]; then
        echo "Warning: $FULL_DEST is a real file/folder, skipping."
    fi
done < "$INPUT_FILE"
