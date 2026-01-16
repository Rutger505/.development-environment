#!/bin/bash

# Add common PPAs and repositories for Ubuntu/Debian

# Helper function to add PPA if not already added
add_ppa_if_missing() {
  local ppa="$1"
  if ! grep -q "^deb.*${ppa}" /etc/apt/sources.list.d/*.list 2>/dev/null; then
    sudo add-apt-repository -y "ppa:$ppa"
  fi
}

# Neovim PPA (for latest stable version)
add_ppa_if_missing "neovim-ppa/stable"

# Update package lists after adding PPAs
sudo apt-get update
