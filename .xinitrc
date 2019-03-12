#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/usr/X11R6/lib/X11/xinit/.Xresources
sysmodmap=/usr/X11R6/lib/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    xmodmap $usermodmap
fi


#[ -f ~/.auto_start ] && source ~/.auto_start
xsetroot -cursor_name left_ptr
if xrandr | grep "HDMI1 connected"; then
    xrandr --output HDMI1 --mode 1920x1080 --left-of LVDS1
fi

setxkbmap -option 'ctrl:nocaps,altwin:swap_alt_win'
# setxkbmap -option 'caps:ctrl_modifier,altwin:swap_alt_win' && xcape -e 'Caps_Lock=Escape' &
ibus-daemon -d --xim

session=${1:-xfce}
case $session in
    awesome           ) exec awesome;;
    bspwm             )
        sxhkd &
        exec bspwm;;
    2bwm              )
        2bwm &
        exec st
        ;;
    catwm             ) exec catwm;;
    cinnamon          ) exec cinnamon-session;;
    dwm               ) exec dwm;;
    enlightenment     ) exec enlightenment_start;;
    ede               ) exec startede;;
    fluxbox           ) exec startfluxbox;;
    gnome             ) exec gnome-session;;
    gnome-classic     ) exec gnome-session --session=gnome-classic;;
    i3|i3wm           ) exec i3;;
    icewm             ) exec icewm-session;;
    jwm               ) exec jwm;;
    kde               ) exec startkde;;
    mate              ) exec mate-session;;
    monster|monsterwm ) exec monsterwm;;
    notion            ) exec notion;;
    openbox           ) exec openbox-session;;
    unity             ) exec unity;;
    xfce|xfce4        ) exec startxfce4;;
    xmonad            ) exec xmonad;;
    # No known session, try to run it as command
    *) exec $1;;
esac

