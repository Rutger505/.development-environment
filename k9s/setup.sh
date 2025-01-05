#!/bin/bash

########## k9S ##########
if ! prompt_installation "K9s Terminal UI for Kubernetes"; then
   return 0
fi

K9S_REPO="derailed/k9s"

# Create temporary directory
if ! TEMP_DIR=$(mktemp -d); then
   echo "Failed to create temporary directory"
   return 1
fi

LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/$K9S_REPO/releases/latest | jq -r '.assets[] | select(.name | contains("Linux_amd64.tar.gz")) | .browser_download_url' | head -n 1)

if [[ -z "$LATEST_RELEASE_URL" ]]; then
   echo "Failed to fetch the latest K9s release"
   rm -rf "$TEMP_DIR"
   return 1
fi

# Download latest K9s
echo "Downloading K9s..."
if ! wget -O "$TEMP_DIR/k9s.tar.gz" "$LATEST_RELEASE_URL"; then
   echo "Failed to download K9s"
   rm -rf "$TEMP_DIR"
   return 1
fi

# Extract K9s
echo "Extracting K9s..."
if ! tar -xzf "$TEMP_DIR/k9s.tar.gz" -C "$TEMP_DIR"; then
   echo "Failed to extract K9s"
   rm -rf "$TEMP_DIR"
   return 1
fi

# Install K9s
echo "Installing K9s..."
if ! sudo install -m 755 "$TEMP_DIR/k9s" /usr/local/bin/k9s; then
   echo "Failed to install K9s"
   rm -rf "$TEMP_DIR"
   return 1
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo "K9s installation completed"




########## Kubectl ##########
if ! prompt_installation "Kubectl Command Line Tool"; then
    return 0
fi

# Create directory for keyring
if ! sudo install -m 0755 -d /etc/apt/keyrings; then
    echo "Failed to create keyring directory"
    return 1
fi

# Download GPG key
echo "Downloading Kubernetes GPG key..."
if ! curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg; then
    echo "Failed to download and install Kubernetes GPG key"
    return 1
fi

# Add Kubernetes repository
echo "Adding Kubernetes repository..."
if ! echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null; then
    echo "Failed to add Kubernetes repository"
    return 1
fi

# Update package list
echo "Updating package list..."
if ! sudo apt-get update; then
    echo "Failed to update package list"
    return 1
fi

# Install kubectl
echo "Installing kubectl..."
if ! sudo apt-get install -y kubectl; then
    echo "Failed to install kubectl"
    return 1
fi

echo "Kubectl installation completed"

