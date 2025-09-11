. $ZSH_CONFIG_DIR/applications/0-tmux.zsh

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
  fzf
  safe-paste
  docker
  npm
  bun
  kubectl
  eza
  nvm
  fnm
  starship
  zoxide
  archlinux
  systemd
  lol
)

source $ZSH/oh-my-zsh.sh


source $ZSH_CONFIG_DIR/aliases.zsh

for file in $ZSH_CONFIG_DIR/applications/*.zsh; do
  [ -r "$file" ] && source "$file"
done