#!/bin/bash

sudo snap install ghostty --classic

echo "Configuring autostart configuration"
cat <<EOF > ~/.config/autostart/ghostty.desktop
[Desktop Entry]
Name=Ghostty
Exec=ghostty
Type=Application
EOF
