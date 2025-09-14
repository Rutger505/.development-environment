#!/bin/bash
# TODO this script can be removed when remove HyDe

# Remove --logo-type kitty alias.
sed -i 's/^\(.*fastfetch --logo-type kitty.*\)$/# \1/' ~/.config/zsh/user.zsh

