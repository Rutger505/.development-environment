. $ZSH_CONFIG_DIR/packages/0-tmux.zsh

# TODO Move this to .zshenv when getting rid of HyDe
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CONFIG_DIR="$ZDOTDIR"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

export PATH=$PATH:/snap/bin
export PATH=$PATH:$HOME/.development-environment/scripts


###### ZSH / Oh My Zsh ######
# TODO move this into $ZSH_CONFIG_DIR/oh-my-zsh/custom/ ?
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"

zstyle ':omz:update' mode disabled

plugins=(
  git
  sudo
  safe-paste
  # System
  archlinux
  systemd
  # Enhancements
  zsh-256color
  zsh-autosuggestions
  zsh-syntax-highlighting
  eza
  starship
  zoxide
  vi-mode
  fzf
  copyfile
  colorize
  # Container
  docker
  kubectl
  # JavaScript / TypeScript / Node.js
  node
  npm
  nvm
  fnm
  bun
  # Python
  python
  pip
  # Fun
  lol
)

source $ZSH/oh-my-zsh.sh

source $ZSH_CONFIG_DIR/aliases.zsh

for file in $ZSH_CONFIG_DIR/packages/*.zsh; do
  [ -r "$file" ] && source "$file"
done