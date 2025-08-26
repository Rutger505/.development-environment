#!/bin/bash

sed -i 's/^\(.*fastfetch --logo-type kitty.*\)$/# \1/' ~/.config/zsh/user.zsh

echo "confirm_os_window_close 0" >> ~/.config/kitty/kitty.conf
