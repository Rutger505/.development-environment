ARGS+=(
  '--icons'
  '--git'
  '--group-directories-first'
)

alias l='eza $ARGS --long'
alias la='eza $ARGS --long --all --group'
alias ll='eza $ARGS --long --group --header'
alias lla='eza $ARGS --long --all --group --header'
alias lt='eza $ARGS --tree --level=2'
alias llt='eza $ARGS --tree --level=4'
alias lr='eza $ARGS --long --recurse'