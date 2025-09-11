#!/bin/bash


yay -S kanata

KANATA_SERVICE_DIR="$HOME/.config/systemd/user"
KANATA_SERVICE="$KANATA_SERVICE_DIR/kanata.service"

echo "Creating user systemd service..."
mkdir -p "$KANATA_SERVICE_DIR"

cat <<EOF > "$KANATA_SERVICE"
[Unit]
Description=Kanata (User Service)
After=graphical.target

[Service]
ExecStart=/usr/bin/kanata
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now kanata.service
