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

if [[ ${#PACKAGES[@]} -eq 0 ]]; then
  echo "No packages selected to install."

  exit 0
fi

# Install paru
if ! command -v paru >/dev/null 2>&1; then
  echo "Paru not found, installing..."

  sudo pacman -S --needed base-devel

  git clone https://aur.archlinux.org/paru.git ~/tmp/paru
  cd ~/tmp/paru || exit 1
  makepkg -si

  cd - || exit 1
  rm -rf ~/tmp/paru
fi

paru -S "${PACKAGES[@]}"

echo "Finished installing applications! 🚀✨"
