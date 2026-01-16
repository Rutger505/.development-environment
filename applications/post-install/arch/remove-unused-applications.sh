#!/usr/bin/env zsh

# Remove packages if installed
yay -Q signal-desktop &> /dev/null && yay -R signal-desktop
yay -Q 1password-beta &> /dev/null && yay -R 1password-beta

cd "${XDG_DATA_HOME:-$HOME/.local/share}/applications" || (echo "Can't change directory to applications" && exit 1)
[ -f Basecamp.desktop ] && rm Basecamp.desktop
[ -f Discord.desktop ] && rm Discord.desktop # The omarchy-web-application variant
[ -f HEY.desktop ] && rm HEY.desktop