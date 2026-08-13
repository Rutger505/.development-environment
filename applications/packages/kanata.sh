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
(defcfg
  ;; Matches the default, set explicitly to silence a startup warning
  process-unmapped-keys no
  ;; Only grab pure keyboards. Combined keyboard+mouse devices would otherwise
  ;; route pointer events through kanata's virtual keyboard, making evdev hotkey
  ;; listeners (gpu-screen-recorder) discard it as a non-keyboard device.
  linux-device-detect-mode keyboard-only
  ;; gpu-screen-recorder creates this device to re-emit the keys it does not
  ;; consume. Grabbing it makes gsr think it has been hijacked, so it drops its
  ;; grab and the focused application receives the hotkeys too.
  linux-dev-names-exclude ("gsr-ui virtual keyboard")
)

;; defsrc is still necessary
(defsrc)
(deflayermap (base-layer)
  caps esc)
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now kanata.service
