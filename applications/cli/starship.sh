#!/bin/bash
# Starship already installed with HyDe
#curl -sS https://starship.rs/install.sh | sh

echo "Removing $HOME/.config/starship/starship.toml file to prevent GNU Stow conflicts"
rm -f "$HOME/.config/starship/starship.toml"
