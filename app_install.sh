#!/bin/bash

# TODO: Install all apps.
# - Check the system what they support. Like apt, flatpak, snap, etc.
# - Have all apt packages installed.
# - Have all flatpak packages installed.

# # Installing neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
nvim --version
