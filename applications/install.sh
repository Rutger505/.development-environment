#!/bin/bash

SCRIPT_DIRECTORY="$(dirname "${BASH_SOURCE[0]}")"
cd "$SCRIPT_DIRECTORY" || exit 1

# Install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git ~/tmp/paru
cd ~/tmp/paru || exit 1
makepkg -si

# Install applications
paru -S \
  bun \
  kanata \
  nvm \
  npm \
  opentofu \
  stow \
  eza \
  neovim \
  kubectl \
  k9s \
  cloc \
  magic-wormhole \
  btop \
  envycontrol \
  powertop \
  powerstat \
  fzf \
  ripgrep \
  fd \
  starship \
  tmux \
  zoxide \
  bitwarden \
  chromium \
  firefox \
  zen-browser \
  discord \
  slack-desktop \
  jetbrains-toolbox \
  visual-studio-code-bin \
  steam \
  snapd \
  cronie

# Nvm
nvm install

# Starship
echo "Removing $HOME/.config/starship/starship.toml file to prevent GNU Stow conflicts"
rm -f "$HOME/.config/starship/starship.toml"

# Tmux
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
~/.local/share/tmux/plugins/tpm/bin/install_plugins all

# zsh
echo "Removing $HOME/.config/zsh/.zshrc file to prevent GNU Stow conflicts"
rm -f "$HOME/.config/zsh/.zshrc"
rm -f "$HOME/.zshrc"

# Kitty
# Remove --logo-type kitty alias.
sed -i 's/^\(.*fastfetch --logo-type kitty.*\)$/# \1/' ~/.config/zsh/user.zsh
# Remove close confirmation because tmux. TODO probably make this conditional on tmux being installed.
echo "confirm_os_window_close 0" >> ~/.config/kitty/kitty.conf

# Snap
sudo systemctl enable --now snapd.socket

# Cronie
sudo systemctl enable --now cronie.service


echo "Finished installing applications! 🚀✨"
