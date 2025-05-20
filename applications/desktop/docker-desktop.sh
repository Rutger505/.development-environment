#!/bin/bash

# 1. Set up Docker's apt repository
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


# 2. Install Docker Desktop .deb
sudo wget https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb -O ./docker-desktop-amd64.deb

# Install the downloaded .deb package
sudo apt-get install ./docker-desktop-amd64.deb

# Remove downloaded docker deb
sudo rm ./docker-desktop-amd64.deb

# Autostart configuration
echo "Creating autostart configuration"
cat << EOF > ~/.config/autostart/docker-desktop.desktop
[Desktop Entry]
Type=Application
Exec=/opt/docker-desktop/bin/docker-desktop
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Docker Desktop
Icon=/opt/docker-desktop/share/icon.original.png
StartupNotify=true
EOF

