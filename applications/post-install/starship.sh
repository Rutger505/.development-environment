#!/bin/bash

echo "Removing $HOME/.config/starship/starship.toml file to prevent GNU Stow conflicts"
rm -f "$HOME/.config/starship/starship.toml"
