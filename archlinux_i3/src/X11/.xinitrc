#!/bin/sh
# ~/.xinitrc

# Load Xresources and Xmodmap if exists
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
[[ -f $sysresources ]]  && xrdb -merge $sysresources
[[ -f $userresources ]] && xrdb -merge "$userresources"
[[ -f $sysmodmap ]]     && xmodmap $sysmodmap
[[ -f $usermodmap ]]    && xmodmap "$usermodmap"

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Default applications
which urxvt >> /dev/null && TERM="urxvt" || TERM=linux
export TERM
which nvim >> /dev/null && EDITOR="/usr/bin/nvim" || EDITOR="/usr/bin/vim"
export EDITOR
export VISUAL=$EDITOR
export BROWSER="firefox"

# Start Window Manager according to parameter
session="$1"
case $session in
    i3 ) exec i3;;
    awesome ) exec awesome;;

    # Unknown session, try to run it as command
    *) exec "$1";;
esac
