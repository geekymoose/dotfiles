#!/bin/sh
#
# ~/.xinitrc
#

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

# Special setting for my Nvidia GPU, but shouldn't be required by others
# See https://wiki.archlinux.org/index.php/NVIDIA_Optimus
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Start Window Manager according to parameter
session="$1"
case $session in
    i3 ) exec i3;;
    awesome ) exec awesome;;

    # Unknown session, try to run it as command
    *) exec "$1";;
esac

