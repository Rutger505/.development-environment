#!/bin/bash

# Download and install fnm:
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

# Init path for this script. This is also in .zshrc but is not sourced yet.
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
	export PATH="$FNM_PATH:$PATH"
	eval "$(fnm env)"
fi

# Download and install Node.js:
fnm install 22
