#!/bin/bash

sudo apt-get install zsh

echo "Changing default shell to Zsh. Please enter password below"
chsh -s "$(which zsh)"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Removing $HOME/.zshrc file to prevent GNU Stow conflicts"
rm -f "$HOME/.zshrc"
