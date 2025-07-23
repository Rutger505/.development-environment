#!/bin/bash
flatpak install flathub com.discordapp.Discord


echo "Configuring autostart for Discord"
ln -s ~/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop ~/.config/autostart/bitwarden.desktop
