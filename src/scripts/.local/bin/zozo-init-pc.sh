#!/bin/bash

source "${HOME}/.config/sh/functions.sh"

echo "Loading the $(hostname) configuration..."

# Custom setup
if [[ $(hostname) == "carrot" ]]; then
    if [[ $XDG_SESSION_TYPE == "X11" ]]; then
        xinput set-prop 11 "libinput Natural Scrolling Enabled" 1
        xinput disable 9 # Disable touchscreen
    fi
fi

if [[ $XDG_SESSION_TYPE == "wayland" ]];then
    IMG_PATH="$HOME/.local/share/backgrounds/background-home.jpg"
    swaybg -m fill -i ${IMG_PATH} &
else
    nitrogen --restore
fi

echo -e "${COLOR_SUCCESS}Init successfully done${COLOR_NORMAL}"
