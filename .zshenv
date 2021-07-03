# if hash gpg-connect-agent 2>/dev/null; then
#   export GPG_TTY="$(tty)"
#   export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
#   gpg-connect-agent updatestartuptty /bye > /dev/null
# fi
# 
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export SB_GIT_HOOKS_DIR=$HOME/.sb-git-hooks

export GITHUB_TOKEN=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
export SB_FLEET_REPO=~/ShopBack/fleet
