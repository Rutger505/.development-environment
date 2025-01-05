#!/bin/bash

if ! prompt_installation "Ghostty Terminal"; then
    return 0
fi


GHOSTTY_UBUNTU_REPO="mkasberg/ghostty-ubuntu"

# Create temporary directory
if ! TEMP_DIR=$(mktemp -d); then
    echo "Failed to create temporary directory"
    return 1
fi

LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/$GHOSTTY_UBUNTU_REPO/releases/latest | jq -r '.assets[] | select(.name | contains("deb") and contains("24")) | .browser_download_url' | head -n 1)

if [[ -z "$LATEST_RELEASE_URL" ]]; then
    echo "Failed to fetch the latest Ghostty release"
    rm -rf "$TEMP_DIR"
    return 1
fi

# Download latest Ghostty
echo "Downloading Ghostty..."
if ! wget -O "$TEMP_DIR/ghostty.deb" "$LATEST_RELEASE_URL"; then
    echo "Failed to download Ghostty"
    rm -rf "$TEMP_DIR"
    return 1
fi

# Install Ghostty
echo "Installing Ghostty..."
if ! sudo dpkg -i "$TEMP_DIR/ghostty.deb"; then
    echo "Failed to install Ghostty"
    rm -rf "$TEMP_DIR"
    return 1
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo "Ghostty installation completed"
