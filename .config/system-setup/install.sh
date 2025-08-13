#!/bin/bash
set -euo pipefail

# Setup symlink to dotfiles using stow.
# Install applications.
# Set linux settings.

# TODO: 
# - Seperate to different files.
# - Add colors.
# - Check what distro we are on.

# ------ Imports ------
# TODO: Import everything from functions folder
source "$(dirname "$0")/functions/reboot.sh"

# ------ Variables ------
APT_PACKAGES_PREINSTALL=(
  git
  # flatpak
  stow
)

# FLATPAK_PACKAGES_PREINSTALL=(
# )

# PATH_DOTFILES="${HOME}/.dotfiles"
DOTFILES_DIR="${HOME}/dotfiles"

TMUX_CONFIG="${HOME}/.tmux.conf"

# Post install
echo "🍓 Preparing system..."

# TODO: Install dotfiles. Probably need a seperate file for this.
# git clone git@github.com:TheDoomfire/dotfiles.git ~/dotfiles
# ~/.dotfiles/.config/system-settings/install.sh

# Reload bashrc
source ~/.bashrc

sudo apt update -qq # -qq = quiet mode

# If any, then install them.
if [ ${#APT_PACKAGES_PREINSTALL[@]} -gt 0 ]; then
  sudo apt install -y --no-install-recommends "${APT_PACKAGES_PREINSTALL[@]}"
fi

# if [ ${#FLATPAK_PACKAGES_PREINSTALL[@]} -gt 0 ]; then
#     # Ensure Flatpak is installed and Flathub added
#     # if ! command -v flatpak &>/dev/null; then
#     #     echo "Setting up Flatpak..."
#     #     sudo apt install -y flatpak
#     #     flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#     # fi
#
#     echo "Installing Flatpak packages: ${FLATPAK_PACKAGES_PREINSTALL[@]}"
#     flatpak install --noninteractive --assumeyes flathub "${FLATPAK_PACKAGES_PREINSTALL[@]}"
# fi

echo "Symlinking dotfiles..."
stow --verbose --target="$HOME" --dir="$DOTFILES_DIR" --restow */
# If stow not working try this:
# cd "$DOTFILES_DIR" && stow .

echo "📦 Installing packages..."
echo "NOT DONE"
# TODO:
# Intall flatpaks too and not just apt packages?
# Example: flatpak install flathub com.usebottles.bottles

# sudo apt update
# sed -E 's/[[:space:]]*#.*$//; s/^[[:space:]]+//; s/[[:space:]]+$//; /^$/d' packages.txt | xargs -r sudo apt install -y

# grep -vE '^#|^$' packages.txt | xargs -r sudo apt install -y
# xargs -a packages.txt sudo apt install -y
# grep -v '^#\|^$' packages.txt | xargs sudo apt install -y
# sudo apt install -y $(grep -vE '^#|^$' packages.txt)

echo "Packages settings..."

# Install plugins using native package management
echo "Installing Neovim plugins..."
# Using lazy.nvim 
nvim --headless -c "Lazy! sync" -c "qa" 2>/dev/null
# nvim --headless -c "lua require('lazy').sync()" -c 'qa!' 2>/dev/null
#
# # Install language servers 
# nvim --headless -c "LspInstall --sync" -c 'qa!' 2>/dev/null

echo "Installing Tmux plugins..."
# Temporary session for tmux
tmux new-session -d -s temp_session
# Source tmux config
tmux source-file "$TMUX_CONFIG"
# Cleanup
tmux kill-session -t temp_session

echo "⚙️  Applying system settings..."

# TODO: 
# Remove all delays.
# Turn off sound effects.
# Set theme
# Set wallpaper?
# Set cursor theme
# Set Dark Mode

# find all the .sh files in the system-settings folder
find system-settings -type f -name '*.sh' | sort | while read -r script; do
    echo "Applying ${script}..."
    # Use bash -e to maintain error handling
    bash -e "$script"
done

echo "🔮 Future Features & Roadmap"
echo "Neovim config + installing plugins..."
echo "Tmux config + installing plugins..."
echo "Latest node version..."
echo ""

echo "✅ Bootstrap complete! System is ready."

# HAVE THIS LAST
prompt_reboot
