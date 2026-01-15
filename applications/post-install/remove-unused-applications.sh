#!/usr/bin/env zsh

yay -R signal-desktop 1password-beta

cd ~/.local/share/applications || (echo "Can't change directory to ~/.local/share/applications" && exit 1)
rm Basecamp.desktop
rm Discord.desktop # The omarchy-web-application variant    
rm HEY.desktop