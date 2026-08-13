HISTFILE="${HISTFILE:-$XDG_STATE_HOME/zsh/history}"
HISTSIZE=100000
SAVEHIST=100000

# zsh creates the history file, but not its parent directory
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

setopt SHARE_HISTORY          # share history between all running shells (tmux panes)
setopt HIST_FCNTL_LOCK        # use fcntl locking: safe with concurrent shells
setopt EXTENDED_HISTORY       # store timestamps
setopt APPEND_HISTORY         # append instead of replacing on exit
setopt HIST_IGNORE_ALL_DUPS   # drop older duplicates of a command
setopt HIST_SAVE_NO_DUPS      # never write duplicates to the history file
setopt HIST_FIND_NO_DUPS      # skip duplicates when searching
setopt HIST_IGNORE_SPACE      # skip commands starting with a space
setopt HIST_REDUCE_BLANKS     # normalize whitespace before storing
setopt HIST_VERIFY            # expand history references instead of running them
unsetopt HIST_EXPIRE_DUPS_FIRST
