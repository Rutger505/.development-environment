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

# Import propt function to display install prompts
source ./utils/prompt.sh

source ./ghostty/setup.sh
source ./zsh/setup.sh
source ./phpstorm/setup.sh
source ./zen-browser/setup.sh
source ./docker-desktop/setup.sh
source ./git/setup.sh