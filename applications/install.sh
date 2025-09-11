#!/bin/bash

SCRIPT_DIRECTORY="$(dirname "${BASH_SOURCE[0]}")"
cd "$SCRIPT_DIRECTORY" || exit 1

source "$SCRIPT_DIRECTORY/functions.sh"

PACKAGES=(
  # Essential packages
  "stow"
  "git"
  "curl"
  "wget"
  "unzip"
  "zip"
  "jq"
  "cloc"
  "zsh"
  "snapd"
  "cronie"
  "magic-wormhole"
  # Applications used in dotfiles
  "zoxide"
  "neovim"
  "kitty"
  # Basic enhancements
  "exa"
  "bat"
  "ripgrep"
  "fd"
  "fzf"
  "btop"
)
SERVICE_PACKAGES=("snapd" "cronie")
AUTOSTART_PACKAGES=()

prompt_for_confirmation "kanata" "true" "service"
# JS/TS
prompt_for_confirmation "nvm"
prompt_for_confirmation "bun"
# DevOps
prompt_for_confirmation "opentofu"
prompt_for_confirmation "kubectl"
prompt_for_confirmation "k9s"
# Power
prompt_for_confirmation "powertop"
prompt_for_confirmation "powerstat"
# GPU / IGPU
prompt_for_confirmation "envycontrol"
# Shell
prompt_for_confirmation "tmux"
prompt_for_confirmation "starship"
# Password Manager
prompt_for_confirmation "bitwarden"
# Browsers
prompt_for_confirmation "chromium"
prompt_for_confirmation "firefox"
prompt_for_confirmation "zen-browser"
# Communication
prompt_for_confirmation "discord"
prompt_for_confirmation "slack-desktop"
# Editors
prompt_for_confirmation "jetbrains-toolbox"
prompt_for_confirmation "visual-studio-code-bin"
# Gaming
prompt_for_confirmation "steam"

# Install paru
if ! command -v paru >/dev/null 2>&1; then
  echo "Paru not found, installing..."

  install_paru
fi

paru -S --needed "${PACKAGES[@]}"

# Post-install scripts
for package in "${PACKAGES[@]}"; do
  POST_INSTALL_SCRIPT="$SCRIPT_DIRECTORY/post-install/${package}.sh"

  if [ -f "$POST_INSTALL_SCRIPT" ]; then
    echo "Running post-install script for $package..."

    "$POST_INSTALL_SCRIPT"
  fi
done

# Enable services
for service in "${SERVICE_PACKAGES[@]}"; do
  echo "Enabling and starting $service service..."
  sudo systemctl enable --now "$service"
done

# Enable autostart applications
AUTOSTART_DIR="$HOME/.config/autostart"
mkdir -p "$AUTOSTART_DIR"
for app in "${AUTOSTART_PACKAGES[@]}"; do
  DESKTOP_FILE_PATH="/usr/share/applications/${app}.desktop"

  if [ -f "$DESKTOP_FILE_PATH" ]; then
    echo "Enabling autostart for $app..."
    ln -s "$DESKTOP_FILE_PATH" "$AUTOSTART_DIR/"
  else
    echo "Warning: Desktop file for $app not found at $DESKTOP_FILE_PATH"
  fi
done

echo "Finished installing applications! 🚀✨"
