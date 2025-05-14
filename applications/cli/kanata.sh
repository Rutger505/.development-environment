wget "https://github.com/jtroo/kanata/releases/latest/download/kanata"

chmod +x kanata

echo "Moving kanata to /usr/bin/kanata"
sudo mv kanata /usr/bin/kanata


echo "Creating system service for kanata."

cat <<EOF | sudo tee "/etc/systemd/system/kanata.service" > /dev/null
[Unit]
Description=Kanata Service
Requires=local-fs.target
After=local-fs.target

[Service]
ExecStart=/usr/bin/kanata -c /etc/kanata/kanata.conf
Restart=no

[Install]
WantedBy=sysinit.target
EOF

echo "Creating kanate config file"
sudo mkdir -p /etc/kanata
cat <<EOF | sudo tee "/etc/kanata/kanata.conf" > /dev/null
;; defsrc is still necessary
(defsrc)
(deflayermap (base-layer)
  caps esc)
EOF

# Reload systemd to recognize the new service
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable kanata.service

# Start the service immediately
sudo systemctl start kanata.service

echo "Kanata service has been created, enabled, and started."

