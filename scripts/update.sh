#!/bin/bash

set -eu

SESSION_NAME="system-update"

# Check if the tmux session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  # Session exists, attach to it
  tmux attach-session -t "$SESSION_NAME"
else
  # Session doesn't exist, create it and run update commands
  tmux new-session -s "$SESSION_NAME" bash -c '
    set -eu

    echo "Updating paru packages"
    paru -Syu

    echo

    echo "Updating snap packages"
    if command -v snap >/dev/null 2>&1; then
      sudo snap refresh
    else
      echo "Snap is not installed. Skipping update."
    fi

    echo

    echo "Updating Flatpak packages"
    if command -v flatpak >/dev/null 2>&1; then
      flatpak update
    else
      echo "Flatpak is not installed. Skipping flatpak update."
    fi

    echo

    echo "Updating OMZ"
    if [ -d "$HOME/.oh-my-zsh" ]; then
      ~/.oh-my-zsh/tools/upgrade.sh
    else
      echo "OMZ is not installed."
    fi

    echo
    echo "All updates completed!"
    echo "Press any key to close this session..."
    read -n 1
  '
fi
