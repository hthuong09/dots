source ~/.zsh/config/environments
source ~/.secret-environments

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx ~/.xinitrc bspwm
fi
