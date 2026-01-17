#!/bin/bash

OMZ_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"

# oh-my-zsh
if [ ! -d "$OMZ_DIR" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_DIR"
fi

# zsh-autosuggestions
if [ ! -d "$OMZ_DIR/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "$OMZ_DIR/custom/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$OMZ_DIR/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$OMZ_DIR/custom/plugins/zsh-syntax-highlighting"
fi

