#!/usr/bin/env zsh

# Disable copy-on-write and compression for Steam on btrfs
# This improves performance for games
mkdir -p ~/.local/share/Steam/steamapps
chattr +C ~/.local/share/Steam/steamapps
# sudo btrfs property set ~/.local/share/Steam/steamapps compression none
