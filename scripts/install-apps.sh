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

# Docker: https://docs.docker.com/engine/install/debian/#uninstall-old-versions
# For Linux Mint: https://linuxiac.com/how-to-install-docker-on-linux-mint-22/
# FIXME: Only works for linux mint.
_setup_docker() {
    echo "Uninstalling old versions of Docker..."
    echo "apt might report that you have none of these packages installed."
    sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)

    # sudo apt update

    # Install prerequisites quietly
    sudo apt install -y apt-transport-https ca-certificates curl gnupg

    # Add Docker’s Official GPG Key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

    # Add Docker Repo to Linux Mint 22
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # Jammy is for Mint 21
    # echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update

    # Install the latest version
    # TODO: Add -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Check if docker is running
    echo "Checking if docker is running..."
    echo "Should say 'active'"
    echo "----------------------------"
    sudo systemctl is-active docker
    echo "----------------------------"

    # If it is not running, start it
    # sudo systemctl start docker

    # Verify Installation
    sudo docker run hello-world

}


_setup_proxmox_backup_server() {
    echo "Installing Proxmox Backup Server..."
    # Add Proxmox GPG key: Using sudo since I geta  permission issue otherwise
    sudo wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg
    # Add the PBS client-only repo
    echo "deb http://download.proxmox.com/debian/pbs-client bullseye main" | sudo tee /etc/apt/sources.list.d/pbs-client.list

    # If a libssl1.1 error is found: Download it manually first:
    wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
    sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

    # The actual installation: If lsubssl1.1 error then run the above code.
    sudo apt install -y proxmox-backup-server
}

# ========================================================
# RUN INSTALLATIONS / TESTS
# ========================================================

echo "Updating system package lists..."
sudo apt update && sudo apt upgrade -y

echo "Installing apps..."

# # For testing:
# _install_from_file "$APT_LIST" "printf '%s\n'"
# _install_from_file "$FLATPAK_LIST" "printf '%s\n'" 


# For real use:
install_from_file "$APT_LIST" "sudo apt install -y"
install_from_file "$FLATPAK_LIST" "flatpak install -y flathub" 

_setup_docker

echo "Done installing apps."

# Remove variables to avoid polluting the environment
unset INSTALLER_DIR
unset APT_LIST
unset FLATPAK_LIST
# unset CURRENT_DIR
