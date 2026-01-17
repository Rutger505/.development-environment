#!/bin/bash

# Install glow (markdown viewer) via snap
if ! command -v glow &> /dev/null; then
  sudo snap install glow
fi
