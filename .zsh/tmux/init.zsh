if ! which tmux &> /dev/null; then
  return 1
fi

if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$SSH_TTY" ]] && [[ "$TERM" != (dumb|linux|*bsd*) && "$TERM_PROGRAM" != "vscode" ]] then
  tmux start-server

  if ! tmux has-session 2> /dev/null; then
    tmux_session='aichan'

    tmux \
      new-session -d -s "$tmux_session" \; \
      set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  exec tmux attach-session
fi
