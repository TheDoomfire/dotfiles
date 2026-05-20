#!/bin/bash

FONTS_DIR="$HOME/.local/share/fonts"
FONT_NAME="Iosevka"
FONT_TEMP="/tmp/$FONT_NAME.zip"
FONT_DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_NAME.zip"

# - TODO: Make this a function. In case I want to change the font.

mkdir -p "$FONT_DIR"
# Download the zip file to your /tmp folder
curl -L -o "$FONT_TEMP" "$FONT_DOWNLOAD_URL"
# Unzip it into your font directory
unzip "$FONT_TEMP"  -d "$FONT_DIR/${FONT_NAME}NerdFont"
# Clean up the zip file
rm "$FONT_TEMP"   
# Update Font Cache
fc-cache -fv
