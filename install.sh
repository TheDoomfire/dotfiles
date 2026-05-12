#!/bin/bash

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)


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

# Restove
# stow -R -v -t ~ home


# TODO: Add all these, so install all apps. 
# Source: https://github.com/TheDoomfire/bootstrap-os

# echo "📦 Installing packages..."


# echo "⚙️  Applying system settings..."

# ----- Set up nerd fonts -----
# - TODO: Make this a function. In case I want to change the font.

FONTS_DIR="$HOME/.local/share/fonts"
FONT_NAME="Iosevka"
FONT_TEMP="/tmp/$FONT_NAME.zip"
FONT_DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_NAME.zip"

mkdir -p "$FONT_DIR"
# Download the zip file to your /tmp folder
curl -L -o "$FONT_TEMP" "$FONT_DOWNLOAD_URL"
# Unzip it into your font directory
unzip "$FONT_TEMP"  -d "$FONT_DIR/${FONT_NAME}NerdFont"
# Clean up the zip file
rm "$FONT_TEMP"   
# Update Font Cache
fc-cache -fv
