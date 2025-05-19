#!/bin/bash
sudo snap install slack

echo "Creating autostart configuration"
cat << EOF > ~/.config/autostart/slack.desktop
[Desktop Entry]
Type=Application
Exec=/snap/bin/slack
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Slack
Comment=Starts the Slack messaging application
Icon=/snap/slack/196/usr/share/pixmaps/slack.png
Categories=Network;InstantMessaging;
StartupNotify=true
EOF

