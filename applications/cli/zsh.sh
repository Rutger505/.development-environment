#!/bin/bash

echo "Removing $HOME/.config/zsh/.zshrc file to prevent GNU Stow conflicts"
rm -f "$HOME/.config/zsh/.zshrc"
rm -f "$HOME/.zshrc"
