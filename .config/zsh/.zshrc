###### Tmux ######
if [[ -z "$TMUX" ]] && [[ $- == *i* ]] && [[ "$TERM" != "tmux-256color" && "$TERM" != "xterm-256color" ]]; then
  tmux attach-session -t 0 2>/dev/null || tmux new-session -s 0
fi

###### PATH additions ######
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/snap/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/typescript-go/built/local
export PATH=$PATH:$HOME/.config/composer/vendor/bin

###### PlatformIO ######
if [ -d ~/.platformio/penv ]; then
  PATH="$PATH:$HOME/.platformio/penv/bin/platformio"
  PATH="$PATH:$HOME/.platformio/penv/bin/pio"
  PATH="$PATH:$HOME/.platformio/penv/bin/piodebuggdb"
fi

###### XDG base dirs ######
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

###### ZSH / Oh My Zsh ######
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"

zstyle ':omz:update' mode disabled:auto

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
)

source $ZSH/oh-my-zsh.sh

# TODO
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

###### Preferred editor ######
export EDITOR=nvim
export VISUAL=nvim

###### pnpm (no OMZ plugin yet → keep inline) ######
export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"
if type compdef &>/dev/null; then
  _pnpm_completion () {
    local reply
    local si=$IFS

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}"))
    IFS=$si

    if [ "$reply" = "__tabtab_complete_files__" ]; then
      _files
    else
      _describe 'values' reply
    fi
  }
  compdef _pnpm_completion pnpm
fi

###### Bun ######
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

###### Kubernetes ######
export KUBECONFIG="$HOME/.kube/config"

###### Aliases ######
alias bruno="flatpak run com.usebruno.Bruno > /dev/null 2>&1 & disown"
alias logout="gnome-session-quit --logout --no-prompt"

# eza handled by OMZ plugin, extend with custom overrides:
alias l='eza --group-directories-first --icons --git --long'
alias la='eza --long --all --group --icons --git --group-directories-first'
alias ll='eza --long --group --header --icons --git --group-directories-first'
alias lla='eza --long --all --group --header --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --group-directories-first --icons --git'
alias llt='eza --tree --level=4 --group-directories-first --icons --git'

alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

###### Docker ######
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

###### Rust ######
export CARGO_HOME="$XDG_DATA_HOME"/cargo