#!/bin/bash

# Check if kanata is installed
if ! command -v kanata &> /dev/null; then
  echo "Kanata is not installed, skipping service setup"
  exit 0
fi

echo "Creating system service"
cat <<EOF | sudo tee "/etc/systemd/system/kanata.service" >/dev/null
[Unit]
Description=Kanata Service
Requires=local-fs.target
After=local-fs.target

[Service]
ExecStart=/usr/bin/kanata -c /etc/kanata/kanata.conf
Restart=on-failure
RestartSec=5

[Install]
WantedBy=sysinit.target
EOF

echo "Creating config file"
sudo mkdir -p /etc/kanata
cat <<EOF | sudo tee "/etc/kanata/kanata.conf" >/dev/null
;; defsrc is still necessary
(defsrc)
(deflayermap (base-layer)
  caps esc)
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now kanata.service
