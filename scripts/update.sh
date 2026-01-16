#!/bin/bash

SESSION_NAME="system-update"

# Distro detection
detect_distro() {
  if [ -f /etc/arch-release ]; then
    echo "arch"
  elif [ -f /etc/debian_version ]; then
    echo "debian"
  else
    echo "unknown"
  fi
}

DISTRO="$(detect_distro)"

# Check if the tmux session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  tmux attach-session -t "$SESSION_NAME"
  exit 0
fi

# Create new session with first pane for system packages
if [ "$DISTRO" = "arch" ]; then
  tmux new-session -d -s "$SESSION_NAME" bash -c '
    set -eu
    echo "Updating yay packages"
    if command -v omarchy-update >/dev/null 2>&1; then
      omarchy-update
    else
      yay -Syu
    fi
    echo
    echo "System update completed!"
    echo "Press any key to close this pane..."
    read -n 1
  '
elif [ "$DISTRO" = "debian" ]; then
  tmux new-session -d -s "$SESSION_NAME" bash -c '
    set -eu
    echo "Updating apt packages"
    sudo apt-get update && sudo apt-get upgrade -y
    echo
    echo "Apt update completed!"
    echo "Press any key to close this pane..."
    read -n 1
  '
else
  echo "Unsupported distro: $DISTRO"
  exit 1
fi

# Split window and create pane for snap (debian only)
if [ "$DISTRO" = "debian" ]; then
  tmux split-window -t "$SESSION_NAME" bash -c '
    set -eu
    echo "Updating snap packages"
    if command -v snap >/dev/null 2>&1; then
      sudo snap refresh
    else
      echo "Snap is not installed. Skipping snap update."
    fi
    echo
    echo "Snap update completed!"
    echo "Press any key to close this pane..."
    read -n 1
  '
fi

# Split window and create pane for flatpak
tmux split-window -t "$SESSION_NAME" bash -c '
  set -eu
  echo "Updating Flatpak packages"
  if command -v flatpak >/dev/null 2>&1; then
    flatpak update -y
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
  OMZ_UPDATE_FILE="${ZSH:-$HOME/.local/share/oh-my-zsh}/upgrade.sh"
  if [ -f "$OMZ_UPDATE_FILE" ]; then
    "$OMZ_UPDATE_FILE"
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
