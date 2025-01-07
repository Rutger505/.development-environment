#!/bin/bash

prompt_installation "Docker Desktop" || return 0

# Create temporary directory for download
TEMP_DIR=$(mktemp -d) || {
    echo "Failed to create temporary directory"
    return 1
}

# Set up Docker's apt repository
# Create keyring directory and add Docker's GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt cache with new repository
if ! sudo apt-get update; then
    echo "Failed to update apt after adding Docker repository"
    rm -rf "$TEMP_DIR"
    return 1
fi

# Install Docker Engine dependencies
echo "Installing Docker Engine dependencies..."
if ! sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; then
    echo "Failed to install Docker Engine dependencies"
    rm -rf "$TEMP_DIR"
    return 1
fi

DOCKER_DEB="$TEMP_DIR/docker-desktop-amd64.deb"

echo "Downloading Docker Desktop..."
if ! wget -O "$DOCKER_DEB" "https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"; then
    echo "Failed to download Docker Desktop"
    rm -rf "$TEMP_DIR"
    return 1
fi

echo "Installing Docker Desktop..."
if ! sudo apt-get install -y "$DOCKER_DEB"; then
    echo "Failed to install Docker Desktop"
    rm -rf "$TEMP_DIR"
    return 1
fi

rm -rf "$TEMP_DIR"

echo "Docker Desktop installed successfully"