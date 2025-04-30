#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
