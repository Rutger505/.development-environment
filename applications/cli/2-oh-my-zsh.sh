#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Removing $HOME/.zshrc file to prevent GNU Stow conflicts"
rm -f "$HOME/.zshrc"
