#!/bin/bash

sudo yay -S tmux

git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm

~/.local/share/tmux/plugins/tpm/bin/install_plugins all

