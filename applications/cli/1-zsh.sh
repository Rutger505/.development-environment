#!/bin/bash

sudo apt-get install zsh

echo "Changing default shell to Zsh. Please enter password below"
chsh -s "$(which zsh)"
