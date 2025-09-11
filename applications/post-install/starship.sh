#!/bin/bash
# TODO this script can be removed when remove HyDe

echo "Removing ~/.config/starship/starship.toml file to prevent GNU Stow conflicts"
rm -f "$HOME/.config/starship/starship.toml"
