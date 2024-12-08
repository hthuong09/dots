# if hash gpg-connect-agent 2>/dev/null; then
#   export GPG_TTY="$(tty)"
#   export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
#   gpg-connect-agent updatestartuptty /bye > /dev/null
# fi
# 
[ -f "$HOME/.shopback" ] && source "$HOME/.shopback"
[ -f "$HOME/.kubectl-alias" ] && source "$HOME/.kubectl-alias"
export FZF_DEFAULT_OPTS=--reverse


export PATH=~/Library/Python/3.8/bin:/usr/local/go/bin:/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-indent/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
