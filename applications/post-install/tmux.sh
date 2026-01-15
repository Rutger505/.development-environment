#!/bin/bash

echo "Installing tmux plugins"
if [ ! -d ~/.local/share/tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
fi
~/.local/share/tmux/plugins/tpm/bin/install_plugins all