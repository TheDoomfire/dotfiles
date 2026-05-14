#!/bin/bash

apply_flatpak_overrides() {
    local TARGET_DIR="$1"
    local FS_PATH="$2"

    # Safety check: ensure both arguments are provided
    if [[ -z "$TARGET_DIR" || -z "$FS_PATH" ]]; then
        echo "Usage: apply_flatpak_overrides /path/to/scan /path/to/allow"
        return 1
    fi

    echo "Scanning: $TARGET_DIR"

    for FOLDER in "$TARGET_DIR"/*; do
        if [ -d "$FOLDER" ]; then
            FOLDER_NAME=$(basename "$FOLDER")
            echo "--> Granting $FOLDER_NAME access to $FS_PATH"
            # flatpak override "$FOLDER_NAME" --filesystem="$FS_PATH"
            echo "Folder: $FOLDER"
        fi
    done
}
