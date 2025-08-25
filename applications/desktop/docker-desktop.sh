#!/bin/bash

wget https://download.docker.com/linux/static/stable/x86_64/docker-28.3.2.tgz -qO- | tar xvfz - docker/docker --strip-components=1

mv ./docker /usr/local/bin


wget https://desktop.docker.com/linux/main/amd64/199162/docker-desktop-x86_64.pkg.tar.zst

sudo pacman -U ./docker-desktop-x86_64.pkg.tar.zst

# Autostart configuration
systemctl --user enable docker-desktop