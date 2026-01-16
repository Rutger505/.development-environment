#!/bin/bash

# Check if tailscale is installed
if ! command -v tailscale &> /dev/null; then
  echo "Tailscale is not installed, skipping service setup"
  exit 0
fi

echo "Enabling tailscaled service"
sudo systemctl enable --now tailscaled
