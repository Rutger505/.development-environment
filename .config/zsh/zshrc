###### Tmux ######
if [[ -z "$TMUX" ]] && [[ $- == *i* ]] && [[ "$TERM" != "tmux-256color" && "$TERM" != "xterm-256color" ]]; then
  tmux attach-session -t 0 2>/dev/null || exec tmux new-session -s 0
fi

###### PATH ######
export PATH=$PATH:$HOME/.local/bin

# Snap
export PATH=$PATH:/snap/bin

# Go installation
export PATH=$PATH:/usr/local/go/bin
# Typescript go port
export PATH=$PATH:$HOME/typescript-go/built/local

# Jetbains Toolbox
# TODO: Maybe i can add a wsl check here. When i am using wsl this scripts won't wexist and will be in /mnt/c/...
export PATH=$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

###### ZSH ######
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"

zstyle ':omz:update' mode disabled  # just remind me to update when it's time


plugins=(git sudo)

source $ZSH/oh-my-zsh.sh


# TODO This may come in handy for utility scripts
# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


###### Zoxide ######
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi


###### Starship ######
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi


###### Preferred editor ######
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export VISUAL=nvim


###### Node Version Manager ######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###### Fast Node Manager ######
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"

  eval "$(fnm env --use-on-cd --shell zsh)"
fi


###### Performant NPM ######
# pnpm
export PNPM_HOME="/home/rutger/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

###-begin-pnpm-completion-###
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
  # When called by the Zsh completion system, this will end with
  # "loadautofunc" when initially autoloaded and "shfunc" later on, otherwise,
  # the script was "eval"-ed so use "compdef" to register it with the
  # completion system
  if [[ $zsh_eval_context == *func ]]; then
    _pnpm_completion "$@"
  else
    compdef _pnpm_completion pnpm
  fi
fi
###-end-pnpm-completion-###


###### Bun ######
# completions
[ -s "/home/rutger/.bun/_bun" ] && source "/home/rutger/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


###### Kubernetes ######
export KUBECONFIG="$HOME/.kube/config"

if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi


###### PHP ######
# Composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# Aliases
alias bruno="flatpak run com.usebruno.Bruno > /dev/null 2>&1 & disown"
alias logout="gnome-session-quit --logout --no-prompt"


###### EZA (LS REPLACEMENT) ######
alias ls='eza --group-directories-first --icons --git'

# Detailed long listing.
alias l='eza --group-directories-first --icons --git --long'
alias la='eza --group-directories-first --icons --git --long --group --all'

alias ll='eza --group-directories-first --icons --git --long --group --header'
alias lla='eza --group-directories-first --icons --git --long --group --header --all'


# Display as a tree (2 levels deep).
alias lt='eza --group-directories-first --icons --git --tree --level=2'

# Display as a deeper tree (4 levels deep).
alias llt='eza --group-directories-first --icons --git --tree --level=4'

###### PlatformIO ######
if [ -d ~/.platformio/penv ]; then
  PATH="$PATH:$HOME/.platformio/penv/bin/platformio"
  PATH="$PATH:$HOME/.platformio/penv/bin/pio"
  PATH="$PATH:$HOME/.platformio/penv/bin/piodebuggdb"
fi;


###### WGET ######
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"


###### Docker ######
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker


###### Rust #####
export CARGO_HOME="$XDG_DATA_HOME"/cargo


######

# Modular sourcing
#for file in $HOME/.development-environment/.config/zsh/aliases.zsh $HOME/.development-environment/.config/zsh/exports.zsh $HOME/.development-environment/.config/zsh/plugins.zsh $HOME/.development-environment/.config/zsh/functions.zsh; do
#  [ -f "$file" ] && source "$file"
#done

# Source all completions
#for completion in $HOME/.development-environment/.config/zsh/completions/*.zsh; do
#  [ -f "$completion" ] && source "$completion"
#done

# Source all path modifications
#for pathfile in $HOME/.development-environment/.config/zsh/paths/*.zsh; do
#  [ -f "$pathfile" ] && source "$pathfile"
#done
