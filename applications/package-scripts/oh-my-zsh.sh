#!/bin/bash

# oh-my-zsh
if [ ! -d ~/.local/share/oh-my-zsh ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.local/share/oh-my-zsh
fi

# zsh-autosuggestions
if [ ! -d ~/.local/share/oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    ~/.local/share/oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d ~/.local/share/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ~/.local/share/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

