#!/bin/bash
set -e

# Script to migrate from GRUB to systemd-boot on Debian
# Run as root

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run as root"
    exit 1
fi

# Check if system is UEFI
if [ ! -d /sys/firmware/efi ]; then
    echo "ERROR: This system is not booted in UEFI mode. systemd-boot requires UEFI."
    exit 1
fi

# Get root partition info
ROOT_PART=$(findmnt -n -o SOURCE /)
ROOT_PARTUUID=$(blkid -s PARTUUID -o value "$ROOT_PART")

# Install systemd-boot
apt-get update > /dev/null 2>&1
apt-get install -y systemd-boot > /dev/null 2>&1

# Install systemd-boot to ESP
bootctl install > /dev/null 2>&1

# Find ESP mount point
ESP_MOUNT=$(bootctl -p)

# Create loader configuration
cat > "$ESP_MOUNT/loader/loader.conf" <<EOF
default debian.conf
timeout 2
console-mode max
editor no
EOF

# Get current kernel version
KERNEL_VERSION=$(uname -r)

# Create boot entry
mkdir -p "$ESP_MOUNT/loader/entries"
cat > "$ESP_MOUNT/loader/entries/debian.conf" <<EOF
title   Debian
linux   /vmlinuz-$KERNEL_VERSION
initrd  /initrd.img-$KERNEL_VERSION
options root=PARTUUID=$ROOT_PARTUUID rw quiet
EOF

# Copy kernel and initrd to ESP
cp /boot/vmlinuz-$KERNEL_VERSION "$ESP_MOUNT/"
cp /boot/initrd.img-$KERNEL_VERSION "$ESP_MOUNT/"

# Remove GRUB and shim
apt-get remove --purge -y grub-efi-amd64 grub-efi-amd64-bin grub-efi-amd64-signed grub-common grub2-common shim-signed shim-unsigned > /dev/null 2>&1 || true
apt-get autoremove -y > /dev/null 2>&1 || true

# Clean up GRUB directories
rm -rf /boot/grub /boot/efi/EFI/debian

echo "SUCCESS: Migration complete. Reboot to use systemd-boot."
