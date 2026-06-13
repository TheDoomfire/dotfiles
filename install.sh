#!/bin/bash

# Imports
source ./scripts/permissions.sh
# source ./scripts/install-apps.sh

# Variables
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SCRIPTS_DIR="$DOTFILES_DIR/scripts"
HDD_PATH="/mnt/movies_games"
SYMLINKS_PATH="$HDD_PATH/data/symlinks"
SYMLINKS_APPS_PATH="$SYMLINKS_PATH/.var/app"

# Incase it's run outside of this directory.
cd "$DOTFILES_DIR"

# If there already is a ~/.config/nvim folder, delete it.
rm -f "$HOME/.config/nvim/lazy-lock.json"

# Install all apps.
# TODO: Add all these, so install all apps. 
# Source: https://github.com/TheDoomfire/bootstrap-os
./scripts/install-apps.sh

# Permissions for docker.
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# TODO: Check the device type and distro.
# TODO: Find a way to see if it's my main pc.
# TODO: Check if my HDD with the name of x exists. Then it's my main pc?

# TODO: Remove all the REAL files. So the correct ones are symlinked?

# Symlinks all files.
# -R = Restow, it deletes the existing symlink and replaces it with the new one.
stow -v -R -t ~ home
stow -v -R -t ~/Documents/Vaults obsidian-config
sudo stow -v -R -t / system

# Heavy files
stow -vt "$HOME" -d "$(dirname "$SYMLINKS_PATH")" "$(basename "$SYMLINKS_PATH")"

# ----- Set up flatpak overrides -----
# Some apps bitch a bit about permissions for another drive.
# TESTME: I haven't tested this yet. Did it manually with flatseal.
apply_flatpak_overrides "$SYMLINKS_APPS_PATH" "$SYMLINKS_PATH"

# ----- Set up nerd fonts -----

bash "$SCRIPTS_DIR/fonts.sh"
