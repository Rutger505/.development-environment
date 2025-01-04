#!/bin/bash

# Ask user if they want to install PHPStorm. Default is yes
read -p "Do you want to install PHPStorm? [Y/n] " -n 1 -r
echo   # Move to a new line
if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "Installing PHPStorm..."
else
    echo "Skipping PHPStorm installation..."
    exit 0
fi


sudo snap install phpstorm --classic