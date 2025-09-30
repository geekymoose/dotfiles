#!/bin/bash
# Run the screenshot utility

if [[ $XDG_SESSION_TYPE == "wayland" ]];then
    grim
else
    xfce4-screenshooter
fi
