#!/bin/bash


echo "Updating apt packages"
sudo apt-get update
sudo apt-get upgrade

echo
echo

echo "Updating snap packages"
sudo snap refresh

echo
echo


echo "Updating Flatpak packages"
if command -v flatpak >/dev/null 2>&1; then
    flatpak update
else
    echo "Flatpak is not installed. Skipping flatpak update."
fi

echo "Updating OMZ"
if [ -d "$HOME/.oh-my-zsh" ]; then
    ~/.oh-my-zsh/tools/upgrade.sh
else
    echo "OMZ is not installed."
fi
