###### Tmux ######
if [[ -z "$TMUX" && "$TERM" != "screen" ]]; then
  exec tmux
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
###### End PATH ######


###### ZSH ######
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

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

###### End ZSH ######


###### Zoxide ######
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi
###### End Zoxide ######


###### Starship ######
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
###### End Starship ######


###### Preferred editor ######
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export VISUAL=nvim
###### End preferred editor ######


###### Node Version Manager ######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
###### End Node Version Manager ######


###### Fast Node Manager ######
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"

  eval "$(fnm env --use-on-cd --shell zsh)"
fi
PATH="$HOME/.local/share/fnm/aliases/default/bin:$PATH"
###### End Fast Node Manager ######


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
###### End Performant NPM ######


###### Bun ######
# completions
[ -s "/home/rutger/.bun/_bun" ] && source "/home/rutger/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
###### End Bun ######


###### Kubernetes ######
export KUBECONFIG="$HOME/.kube/config"

if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi
###### End Kubernetes ######


###### PHP ######
if [ -d "$HOME/.phpenv" ]; then
  export PHPENV_ROOT="$HOME/.phpenv"
  export PATH="$PHPENV_ROOT/bin:$PATH"
  eval "$(phpenv init -)"
fi

# Composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin
###### End PHP ######


alias bruno="flatpak run com.usebruno.Bruno > /dev/null 2>&1 & disown"
