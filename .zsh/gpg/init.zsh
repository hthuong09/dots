alias sendgpgkey="gpg --keyserver pool.sks-keyservers.net --send-keys E01DB409642851D1"
alias receivegpgkey="gpg --keyserver pool.sks-keyservers.net --recv-keys E01DB409642851D1"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye > /dev/null

