#!/bin/bash

########### Setup zsh ##########
# Check if script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then 
    echo "Please run this script with sudo privileges"
    exit 1
fi

# Check if running on Ubuntu
if ! command -v apt-get &> /dev/null; then
    echo "This script only supports Ubuntu systems"
    exit 1
fi

echo "Installing ZSH..."
apt-get update
apt-get install -y zsh

# Check if installation was successful
if ! command -v zsh &> /dev/null; then
    echo "ZSH installation failed"
    exit 1
fi

# Add ZSH to available shells if not already present
if ! grep -q "$(command -v zsh)" /etc/shells; then
    command -v zsh | tee -a /etc/shells
fi

# Change default shell for the actual user (not root)
ACTUAL_USER=$(logname || echo $SUDO_USER)
if [ -z "$ACTUAL_USER" ]; then
    echo "Could not determine the actual user"
    exit 1
fi

echo "Setting ZSH as default shell for user $ACTUAL_USER..."
chsh -s "$(command -v zsh)" "$ACTUAL_USER"

# Verify installation
echo "ZSH version:"
zsh --version

echo "Installation complete!"
echo "Please log out and log back in for changes to take effect."

echo "Installing Oh My Zsh..."
su - "$ACTUAL_USER" -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

########### Setup ZSH Config Sync Service ##########
echo "Setting up ZSH config sync service..."

# Make the script executable
chmod +x /home/$ACTUAL_USER/.development-environment/zsh/sync.sh

# Create systemd user directory
mkdir -p /home/$ACTUAL_USER/.config/systemd/user/

# Create the service file
cat << EOF > /home/$ACTUAL_USER/.config/systemd/user/zshrc-sync.service
[Unit]
Description=ZSH Config Auto-Sync Service
After=network-online.target

[Service]
Type=simple
ExecStart=/bin/bash /home/$ACTUAL_USER/.setup-development-environment/zshrc-sync.sh
Restart=always
RestartSec=30

[Install]
WantedBy=default.target
EOF

# Set correct ownership
chown -R $ACTUAL_USER:$ACTUAL_USER /home/$ACTUAL_USER/.config/systemd

# Enable and start the service for the user
su - $ACTUAL_USER -c 'systemctl --user enable zshrc-sync.service'
su - $ACTUAL_USER -c 'systemctl --user start zshrc-sync.service'

# Enable user services to run on boot
loginctl enable-linger $ACTUAL_USER

echo "ZSH config sync service has been set up and started."
echo "You can check the service status with: systemctl --user status zshrc-sync.service"