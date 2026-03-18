#!/bin/bash

# Install Ghostty via PPA
if ! command -v ghostty &> /dev/null; then
  sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu
  sudo apt-get update
  sudo apt-get install -y ghostty
fi
