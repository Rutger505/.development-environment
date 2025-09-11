#!/bin/bash
# TODO this script can be removed when remove HyDe

echo "Removing ~/.config/zsh/.zshrc and ~/.zshrc file to prevent Stow conflicts"
rm -f "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"
