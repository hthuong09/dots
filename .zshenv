if hash gpg-connect-agent 2>/dev/null; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  gpg-connect-agent updatestartuptty /bye > /dev/null
fi

