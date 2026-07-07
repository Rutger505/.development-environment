if command -v tmux > /dev/null 2>&1; then
  if [[ -z "$TMUX" ]] && [[ $- == *i* ]] && [[ "$TERM" != "tmux-256color" ]] && [[ "$TERMINAL_EMULATOR" != *JetBrains* ]]; then
    tmux attach-session -t "0" 2>/dev/null || tmux new-session -s "0"
  fi
fi
