# XDG Standards
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CONFIG_DIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$XDG_DATA_HOME/oh-my-zsh"

export HISTFILE="$XDG_STATE_HOME/zsh/history"


export NVM_DIR="$XDG_DATA_HOME"/nvm
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export BUN_INSTALL="$HOME/.bun"
export W3M_DIR="$XDG_DATA_HOME/w3m"
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose



export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.development-environment/scripts"
export PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"
export PATH="$PNPM_HOME:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"

export DEVELOPMENT_ENVIRONMENT_ERROR_FILE="$HOME/development-environment-synchronization-error"


