#!/bin/bash

# ==============================================================================
# SCRIPT: fix_boot_fallback.sh
# PURPOSE: Reinstalls the EFI bootloader to the "Fallback" location.
# 
# PROBLEM DESCRIPTION:
# Use this script if the laptop fails to boot with a "No boot device found" 
# or "Operating system not found" error, even though the internal hard drive 
# is detected in the BIOS/UEFI.
# 
# This often occurs when:
# 1. The UEFI NVRAM entry for the bootloader has been lost or corrupted.
# 2. The motherboard firmware only looks for the standardized Fallback 
#    location (/EFI/BOOT/bootx64.efi) rather than the distribution-specific 
#    path (/EFI/debian/grubx64.efi).
# 
# USAGE: 
# Run this script from a Live USB environment. Ensure the partitions 
# defined below are correct for your current system.
# ==============================================================================

# --- Configuration Variables ---

# Find your partitions using command: lsblk
# Root partition is where your OS is installed. The SSD or the largest partition.
ROOT_PARTITION="/dev/sda3"
# EFI partition is usually 100mb-1gb FAT32 or VFAT, the smallest partition.
EFI_PARTITION="/dev/sda1"

MOUNT_POINT="/mnt"
EFI_MOUNT_POINT="$MOUNT_POINT/boot/efi"
SOURCE_EFI_DIR="$EFI_MOUNT_POINT/EFI/debian"
DEST_EFI_DIR="$EFI_MOUNT_POINT/EFI/BOOT"


# --- Script Execution ---

# Mount partitions
sudo mount "$ROOT_PARTITION" "$MOUNT_POINT"
sudo mkdir -p "$EFI_MOUNT_POINT"
sudo mount "$EFI_PARTITION" "$EFI_MOUNT_POINT"

# sudo mount /dev/sda3 /mnt
# sudo mkdir -p /mnt/boot/efi
# sudo mount /dev/sda1 /mnt/boot/efi

# Fallback directory
sudo mkdir -p "$DEST_EFI_DIR"
sudo cp "$SOURCE_EFI_DIR"/* "$DEST_EFI_DIR/"

# sudo mkdir -p /mnt/boot/efi/EFI/BOOT
# sudo cp /mnt/boot/efi/EFI/debian/* /mnt/boot/efi/EFI/BOOT/

# Rename the bootloader to the standard "Fallback" name
sudo mv "$DEST_EFI_DIR/grubx64.efi" "$DEST_EFI_DIR/bootx64.efi"

# sudo mv /mnt/boot/efi/EFI/BOOT/grubx64.efi /mnt/boot/efi/EFI/BOOT/bootx64.efi

# Cleanup
sync
sudo umount -R "$MOUNT_POINT"
# sudo umount -R /mnt
