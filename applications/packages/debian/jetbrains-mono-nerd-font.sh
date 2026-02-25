#!/bin/bash

# Install JetBrains Mono Nerd Font
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
FONT_NAME="JetBrainsMono"

# Check if font is already installed
if fc-list | grep -qi "JetBrainsMono Nerd Font"; then
  echo "JetBrains Mono Nerd Font is already installed"
  exit 0
fi

# Create font directory
mkdir -p "$FONT_DIR"

# Download the latest JetBrains Mono Nerd Font
echo "Downloading JetBrains Mono Nerd Font..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz

# Extract to fonts directory
echo "Installing font..."
tar -xf JetBrainsMono.tar.xz -C "$FONT_DIR"

# Clean up
rm -rf "$TEMP_DIR"

# Update font cache
fc-cache -fv

echo "JetBrains Mono Nerd Font installed successfully!"
