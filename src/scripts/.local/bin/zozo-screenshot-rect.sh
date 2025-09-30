#!/bin/bash
# Run the screenshot utility (open for a specific rectangle)

if [[ $XDG_SESSION_TYPE == "wayland" ]];then
    slurp | grim -g -
else
    xfce4-screenshooter -w -s "$HOME/downloads/"
fi
