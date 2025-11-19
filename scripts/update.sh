#!/bin/bash

set -eu

SESSION_NAME="system-update"

# Check if the tmux session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  # Session exists, attach to it and exit
  tmux attach-session -t "$SESSION_NAME"
  exit 0
fi

# Create new session with first pane for paru
tmux new-session -d -s "$SESSION_NAME" bash -c '
  set -eu
  echo "Updating paru packages"
  paru -Syu
  echo
  echo "Paru update completed!"
  echo "Press any key to close this pane..."
  read -n 1
'

# Split window and create pane for snap
tmux split-window -t "$SESSION_NAME" bash -c '
  set -eu
  echo "Updating snap packages"
  if command -v snap >/dev/null 2>&1; then
    sudo snap refresh
  else
    echo "Snap is not installed. Skipping update."
  fi
  echo
  echo "Snap update completed!"
  echo "Press any key to close this pane..."
  read -n 1
'

# Split window and create pane for flatpak
tmux split-window -t "$SESSION_NAME" bash -c '
  set -eu
  echo "Updating Flatpak packages"
  if command -v flatpak >/dev/null 2>&1; then
    flatpak update
  else
    echo "Flatpak is not installed. Skipping flatpak update."
  fi
  echo
  echo "Flatpak update completed!"
  echo "Press any key to close this pane..."
  read -n 1
'

# Split window and create pane for OMZ
tmux split-window -t "$SESSION_NAME" bash -c '
  set -eu
  echo "Updating OMZ"
  if [ -d "$HOME/.oh-my-zsh" ]; then
    ~/.oh-my-zsh/tools/upgrade.sh
  else
    echo "OMZ is not installed."
  fi
  echo
  echo "OMZ update completed!"
  echo "Press any key to close this pane..."
  read -n 1
'

# Arrange panes in tiled layout
tmux select-layout -t "$SESSION_NAME" tiled

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
