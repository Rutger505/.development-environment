#!/bin/bash

# Check if kanata is installed
if ! command -v kanata &> /dev/null; then
  echo "Kanata is not installed, skipping service setup"
  exit 0
fi

# Add user to input group (required for kanata on Arch)
if [ -f /etc/arch-release ]; then
  sudo usermod -aG input "$USER"
fi

echo "Creating system service"
cat <<EOF | sudo tee "/etc/systemd/system/kanata.service" >/dev/null
[Unit]
Description=Kanata Service
Requires=local-fs.target
After=local-fs.target

[Service]
ExecStart=$(command -v kanata) -c /etc/kanata/kanata.conf
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
