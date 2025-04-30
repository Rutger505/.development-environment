#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
