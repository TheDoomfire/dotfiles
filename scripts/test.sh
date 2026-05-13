#!/bin/bash

HDD_PATH="/mnt/movies_games"
SYMLINKS_PATH="$HDD_PATH/data/symlinks"

# Stow from the parent of the symlinks folder
stow -vt "$HOME" -d "$(dirname "$SYMLINKS_PATH")" "$(basename "$SYMLINKS_PATH")"
