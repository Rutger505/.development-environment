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
  "gparted"
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
# Github
prompt_for_confirmation "github-cli"
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
prompt_for_confirmation "minecraft-launcher"

# Install paru
if ! command -v paru >/dev/null 2>&1; then
  echo "Paru not found, installing..."

  install_paru
fi

paru -Sy --needed "${PACKAGES[@]}"

run_post_install_scripts "$SCRIPT_DIRECTORY" "${PACKAGES[@]}"
enable_services "${SERVICE_PACKAGES[@]}"
enable_autostart_apps "${AUTOSTART_PACKAGES[@]}"

echo "Finished installing applications! 🚀✨"
