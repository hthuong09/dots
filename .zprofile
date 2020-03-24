source ~/.zsh/config/environments
[[ -f ~/.secret-environments ]] && source ~/.secret-environments

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx ~/.xinitrc bspwm
fi
