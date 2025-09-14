if command -v z >/dev/null @>&1; then
  alias cd='z'
fi

alias l='eza --group-directories-first --icons --git --long'
alias la='eza --long --all --group --icons --git --group-directories-first'
alias ll='eza --long --group --header --icons --git --group-directories-first'
alias lla='eza --long --all --group --header --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --group-directories-first --icons --git'
alias llt='eza --tree --level=4 --group-directories-first --icons --git'

alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

alias zshconfig="$VISUAL $ZSH_CONFIG_DIR/.zshrc"
