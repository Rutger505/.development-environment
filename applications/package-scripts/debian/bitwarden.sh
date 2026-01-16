#!/bin/bash

# Install Bitwarden via snap
if ! command -v bitwarden &> /dev/null; then
  sudo snap install bitwarden
fi
