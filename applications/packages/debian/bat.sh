#!/bin/bash

# On Debian/Ubuntu, bat is installed as 'batcat' due to name conflict
# Create symlink so we can use 'bat' command
if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
  mkdir -p ~/.local/bin
  ln -sf $(which batcat) ~/.local/bin/bat
fi
