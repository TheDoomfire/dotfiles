#!/bin/bash

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

SCRIPTS_DIR="$DOTFILES_DIR/scripts"

HDD_PATH="/mnt/movies_games"
SYMLINKS_PATH="$HDD_PATH/data/symlinks"

# Incase it's run outside of this directory.
cd "$DOTFILES_DIR"

# TODO: Check if stow is installed. 
# If not, install it. Flatpak first then apt.

# If there already is a ~/.config/nvim folder, delete it.
rm -f "$HOME/.config/nvim/lazy-lock.json"

# DELETES ALL SYMLINKS.
# stow -D -t ~ home home-docs-vaults
stow -D -t ~ home
stow -D -t ~/Documents/Vaults obsidian-config
sudo stow -t / -D system

# Symlinks all files.
stow -v -t ~ home
stow -v -R -t ~/Documents/Vaults obsidian-config
sudo stow -v -t / system
# stow -v -R --adopt -t ~ home # Adopt the existing folder

# Heavy files
stow -vt "$HOME" -d "$(dirname "$SYMLINKS_PATH")" "$(basename "$SYMLINKS_PATH")"

# Reastow example:
# stow -R -t ~ symlinks

# TODO: Add all these, so install all apps. 
# Source: https://github.com/TheDoomfire/bootstrap-os

# ----- Set up nerd fonts -----

bash "$SCRIPTS_DIR/fonts.sh"
