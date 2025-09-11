. $ZSH_CONFIG_DIR/applications/0-tmux.zsh

export EDITOR=nvim
export VISUAL=nvim

###### PATH additions ######
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/snap/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/typescript-go/built/local
export PATH=$PATH:$HOME/.config/composer/vendor/bin

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





