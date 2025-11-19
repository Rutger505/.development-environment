#!/bin/bash

SESSION_NAME="system-update"

attach_session() {
  ghostty -e tmux attach-session -t "$SESSION_NAME"
}

# Check if the tmux session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  attach_session
  exit 0
fi

# Create new session with first pane for system packages
tmux new-session -d -s "$SESSION_NAME" bash -c '
  set -eu
  echo "Updating paru packages"
  omarchy-update
  echo
  echo "Paru update completed!"
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
  OMZ_UPDATE_FILE="$ZSH/upgrade.sh"
  if [ -f "$OMZ_UPDATE_FILE" ]; then
    $OMZ_UPDATE_FILE
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
attach_session
