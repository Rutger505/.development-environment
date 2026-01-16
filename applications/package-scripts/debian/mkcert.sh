#!/bin/bash

# Install mkcert for local HTTPS certificates
if ! command -v mkcert &> /dev/null; then
  sudo apt-get install -y libnss3-tools
  MKCERT_VERSION=$(curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
  curl -Lo /tmp/mkcert "https://github.com/FiloSottile/mkcert/releases/download/${MKCERT_VERSION}/mkcert-${MKCERT_VERSION}-linux-amd64"
  chmod +x /tmp/mkcert
  sudo mv /tmp/mkcert /usr/local/bin/mkcert
fi
