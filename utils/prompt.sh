#!/bin/bash

# Function to generate installation prompt
# Arguments:
#   $1: Software name
#   $2: Description (optional)
# Returns:
#   0 if user wants to install, 1 if user does not want to install
prompt_installation() {
    local software=$1
    local description=${2:-""}

    if [ -n "$description" ]; then
        echo "$description"
    fi

    read -p "Do you want to install $software? [Y/n] " -n 1 -r
    echo  # Move to a new line

    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        echo "Installing $software..."
        return 0
    else
        echo "Skipping $software installation..."
        return 1
    fi
}
