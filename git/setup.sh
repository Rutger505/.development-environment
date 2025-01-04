#!/bin/bash

prompt_installation "Git" "Git requires email and name to be configured before use" || return 0

sudo apt-get update
sudo apt-get install -y git

read -p "Enter your Git user name: " git_name
read -p "Enter your Git email address: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "Setting default branch name to 'main'"
git config --global init.defaultBranch main

echo "Git configuration:"
git config --list

echo "Git installation and configuration completed"