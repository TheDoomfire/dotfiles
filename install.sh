#!/bin/bash

# Incase it's run outside of this directory.
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$DOTFILES_DIR"

# TODO: Check if stow is installed. 
# If not, install it. Flatpak first then apt.

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

# Restove
# stow -R -v -t ~ home


# TODO: Add all these, so install all apps. 
# Source: https://github.com/TheDoomfire/bootstrap-os

# echo "📦 Installing packages..."


# echo "⚙️  Applying system settings..."
