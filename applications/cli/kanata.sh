wget "https://github.com/jtroo/kanata/releases/latest/download/kanata"

chmod +x kanata

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

# Reload systemd to recognize the new service
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable kanata.service

# Start the service immediately
sudo systemctl start kanata.service

echo "Kanata service has been created, enabled, and started."

