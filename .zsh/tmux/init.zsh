if ! which tmux &> /dev/null; then
  return 1
fi

if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$SSH_TTY" ]] && [[ "$TERM" != (dumb|linux|*bsd*)  ]] then
  tmux start-server

  if ! tmux has-session 2> /dev/null; then
    tmux_session='hthuong09'

    tmux \
      new-session -d -s "$tmux_session" \; \
      set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  exec tmux attach-session
fi
