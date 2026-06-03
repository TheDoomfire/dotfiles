#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# ========================================================
# CONFIGURATION / PATHS
# ========================================================

# CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
INSTALLER_DIR="data/installer"

APT_LIST="$INSTALLER_DIR/apt-apps.txt"
FLATPAK_LIST="$INSTALLER_DIR/flatpak-apps.txt"

# ========================================================
# FUNCTIONS
# ========================================================

_install_from_file() {
    local file=$1
    local install_cmd=$2
    local app_list=""

    if [ ! -f "$file" ]; then
        echo "Warning: $file not found. Skipping."
        return
    fi

    # Read file line by line, ignore comments (#) and empty lines
    while IFS= read -r line || [ -n "$line" ]; do
        # Strip comments and trim whitespace
        clean_line=$(echo "$line" | sed 's/#.*//' | xargs)
        
        # If the line is not empty, add it to our installation list
        if [ -n "$clean_line" ]; then
            app_list="$app_list $clean_line"
        fi
    done < "$file"

    # If we found apps to install, run the command
    if [ -n "$app_list" ]; then
        echo "Installing apps from $file..."
        eval "$install_cmd $app_list"
    else
        echo "No apps found to install in $file."
    fi
}

# # FIXME: Is linux mint not supported by docker?
# # Docker: https://docs.docker.com/engine/install/debian/#uninstall-old-versions
# _setup_docker() {
#     echo "Uninstalling old versions of Docker..."
#     echo "apt might report that you have none of these packages installed."
#     sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)
#
#     # sudo apt update
#
#     # Install prerequisites quietly
#     sudo apt install ca-certificates curl
#
#     # Create the keyrings directory securely
#     sudo install -m 0755 -d /etc/apt/keyrings
#
#
#     # Download GPG key (Overwrite if it exists to keep it fresh)
#     sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
#     sudo chmod a+r /etc/apt/keyrings/docker.asc
#
#     # Add the repository to Apt sources:
#     sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
#     Types: deb
#     URIs: https://download.docker.com/linux/debian
#     Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
#     Components: stable
#     Architectures: $(dpkg --print-architecture)
#     Signed-By: /etc/apt/keyrings/docker.asc
#     EOF
#
#     sudo apt update
# }


# ========================================================
# RUN INSTALLATIONS / TESTS
# ========================================================

echo "Updating system package lists..."
sudo apt update && sudo apt upgrade -y

echo "Installing apps..."

# For testing:
_install_from_file "$APT_LIST" "printf '%s\n'"
_install_from_file "$FLATPAK_LIST" "printf '%s\n'" 


# # For real use:
# install_from_file "$APT_LIST" "sudo apt install -y"
# install_from_file "$FLATPAK_LIST" "flatpak install -y flathub" 


# FIXME: Is linux mint not supported by docker?
# _setup_docker

echo "Done installing apps."

# Remove variables to avoid polluting the environment
unset INSTALLER_DIR
unset APT_LIST
unset FLATPAK_LIST
# unset CURRENT_DIR
