#!/bin/bash

# TODO open a new popup terminal with tmux and panes for earch update. 

echo "Updating paru packages"
omarchy-update

echo

echo "Updating Flatpak packages"
if command -v flatpak >/dev/null 2>&1; then
    flatpak update
else
    echo "Flatpak is not installed. Skipping flatpak update."
fi

echo

echo "Updating OMZ"
OMZ_UPDATE_FILE="$ZSH/upgrade.sh"
if [ -f "$OMZ_UPDATE_FILE" ]; then
    $OMZ_UPDATE_FILE
else
    echo "OMZ is not installed."
fi
