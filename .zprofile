source ~/.zsh/config/environments
[[ -f ~/.secret-environments ]] && source ~/.secret-environments

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx ~/.xinitrc bspwm
fi
