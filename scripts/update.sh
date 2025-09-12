#!/bin/bash

set -eu

echo "Updating paru packages"
paru -Syu

echo
echo

echo "Updating snap packages"
if command -v snap >/dev/null 2>&1; then
  sudo snap refresh
else
  echo "Snap is not installed. Skipping update."
fi

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
