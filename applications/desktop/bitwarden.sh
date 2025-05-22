#!/bin/bash

flatpak install flathub com.bitwarden.desktop

echo "Configuring autostart for Bitwarden"
sudo ln /var/lib/flatpak/exports/share/applications/com.bitwarden.desktop.desktop ~/.config/autostart/bitwarden.desktop
