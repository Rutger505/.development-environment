#!/bin/bash

# Install JetBrains Toolbox
TOOLBOX_DIR="/opt/jetbrains-toolbox"

if [ ! -d "$TOOLBOX_DIR" ]; then
  TOOLBOX_URL=$(curl -s "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release" | grep -oP '"linux":\s*{\s*"link":\s*"\K[^"]+')

  if [ -n "$TOOLBOX_URL" ]; then
    TEMP_DIR=$(mktemp -d)
    curl -L "$TOOLBOX_URL" -o "$TEMP_DIR/jetbrains-toolbox.tar.gz"
    sudo mkdir -p "$TOOLBOX_DIR"
    sudo tar -xzf "$TEMP_DIR/jetbrains-toolbox.tar.gz" -C "$TOOLBOX_DIR" --strip-components=1
    rm -rf "$TEMP_DIR"
    echo "JetBrains Toolbox installed to $TOOLBOX_DIR"
  else
    echo "Failed to get JetBrains Toolbox download URL"
  fi
fi
