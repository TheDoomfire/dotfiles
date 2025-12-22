#!/bin/bash

# Incase it's run outside of this directory.
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$DOTFILES_DIR"

# TODO: Check if stow is installed. 
# If not, install it. Flatpak first then apt.

# DELETES ALL SYMLINKS.
stow -D -t ~ home
sudo stow -t / -D system

# Symlinks all files.
stow -v -t ~ home 
sudo stow -v -t / system
