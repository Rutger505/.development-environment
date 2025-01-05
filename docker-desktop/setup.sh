#!/bin/bash

prompt_installation "Docker Desktop" || return 0

# Create temporary directory for download
TEMP_DIR=$(mktemp -d) || {
    echo "Failed to create temporary directory"
    return 1
}

DOCKER_DEB="$TEMP_DIR/docker-desktop-amd64.deb"

echo "Downloading Docker Desktop..."
if ! wget -O "$DOCKER_DEB" "https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"; then
    echo "Failed to download Docker Desktop"
    rm -rf "$TEMP_DIR"
    return 1
fi

echo "Installing Docker Desktop..."
if ! sudo apt-get update; then
    echo "Failed to update apt"
    rm -rf "$TEMP_DIR"
    return 1
fi

if ! sudo apt-get install -y "$DOCKER_DEB"; then
    echo "Failed to install Docker Desktop"
    rm -rf "$TEMP_DIR"
    return 1
fi

rm -rf "$TEMP_DIR"

echo "Docker Desktop installed successfully"
