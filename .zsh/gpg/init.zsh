alias sendgpgkey="gpg --keyserver pool.sks-keyservers.net --send-keys 7CFC941A76EDB5FD"
alias receivegpgkey="gpg --keyserver pool.sks-keyservers.net --recv-keys 7CFC941A76EDB5FD"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye > /dev/null

