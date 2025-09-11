# TODO call these post install directely.

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
echo "confirm_os_window_close 0" >>~/.config/kitty/kitty.conf

# Snap
sudo systemctl enable --now snapd.socket

# Cronie
sudo systemctl enable --now cronie.service