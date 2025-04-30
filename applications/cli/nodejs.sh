#!/bin/bash

# Download and install fnm:
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

source "$HOME/.bashrc"
source "$HOME/.zshrc"

# Download and install Node.js:
fnm install 22
