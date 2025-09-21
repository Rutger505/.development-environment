#!/bin/bash

if [ ! -f ~/.config/hypr/monitors.conf ] || [ ! -f ~/.config/hypr/workspaces.conf ]; then
    echo "Creating Hyprland display configuration files..."
    mkdir -p ~/.config/hypr
    touch ~/.config/hypr/monitors.conf
    touch ~/.config/hypr/workspaces.conf
fi
