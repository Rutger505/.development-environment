#!/bin/bash

# Check if script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo privileges"
    exit 1
fi

# Check if running on Ubuntu
if ! command -v apt-get &> /dev/null; then
    echo "This script only supports Ubuntu systems"
    exit 1
fi

echo "Installing dependencies..."
apt-get update
apt-get install -y curl jq


# Import propt function to display install prompts
source ./utils/prompt.sh

scripts=(
   "ghostty"
   "zsh"
   "phpstorm"
   "zen-browser"
   "docker-desktop"
   "git"
   "k9s"
)

for script in "${scripts[@]}"; do
   if [ -f "./$script/setup.sh" ]; then
       source "./$script/setup.sh"
   else
       echo "Error: ./$script/setup.sh not found"
       exit 1
   fi
done