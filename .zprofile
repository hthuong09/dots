source ~/.zsh/config/environments
[[ -f ~/.secret-environments ]] && source ~/.secret-environments
export SB_GIT_HOOKS_DIR=$HOME/.sb-git-hooks

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx ~/.xinitrc bspwm
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
