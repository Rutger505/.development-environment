#!/bin/bash

sudo flatpak install flathub app.zen_browser.zen

echo "Configuring autostart for Zen"
sudo ln -s /var/lib/flatpak/exports/share/applications/app.zen_browser.zen.desktop ~/.config/autostart/zen-browser.desktop
