#!/bin/bash

# --- Configuration ---
REBOOT_BTW_PACKAGE="reboot-arch-btw" # The package name for reboot-arch-btw
HOOK_FILE="/etc/pacman.d/hooks/99-reboot-arch-btw.hook"
EXECUTABLE="/usr/bin/reboot-arch-btw"

# --- Main script execution ---

echo "Creating pacman hook file: $HOOK_FILE"

# Get current user and UID to correctly set DBUS_SESSION_BUS_ADDRESS
local_user=$(whoami)
local_uid=$(id -u "$local_user")

if [ -z "$local_user" ] || [ -z "$local_uid" ]; then
    echo "Error: Could not determine current user or UID. Exiting."
    exit 1
fi

# Define the Exec command for the hook, including user-specific D-Bus setup
# This ensures reboot-arch-btw can send desktop notifications
DBUS_EXEC_COMMAND="/usr/bin/sudo -u #$local_uid DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$local_uid/bus $EXECUTABLE"

sudo mkdir -p /etc/pacman.d/hooks
sudo bash -c "cat << EOF > \"$HOOK_FILE\"
[Trigger]
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = Check whether a reboot is required with reboot-arch-btw
Depends = $REBOOT_BTW_PACKAGE
When = PostTransaction
Exec = $DBUS_EXEC_COMMAND --notification-timeout 15000 --reboot-packages systemd,linux-firmware,amd-ucode,intel-ucode,mkinitcpio --session-restart-packages xorg-server,xorg-xwayland,hyprland,sddm
EOF"


echo "Pacman hook created successfully at $HOOK_FILE"