source ~/.zsh/config/environments
[[ -f ~/.secret-environments ]] && source ~/.secret-environments

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx ~/.xinitrc bspwm
fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
