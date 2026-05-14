#!/bin/bash

# ----- TEST FILE -----
# FOR TESTING ONLY
# When successfully tested add to install.sh
# ----------------------

source ./scripts/permissions.sh

MY_HDD="/mnt/movies_games"
SCAN_PATH="$MY_HDD/data/symlinks/.var/app"
ALLOW_PATH="$MY_HDD/data/symlinks"

apply_flatpak_overrides "$SCAN_PATH" "$ALLOW_PATH"
