#!/bin/bash
# Lock the PC with a custom background

IMG_PATH="$HOME/.local/share/backgrounds/background-lock.png"

if [[ $XDG_SESSION_TYPE == "wayland" ]];then
    swaylock -e -F -f -k -l -s fill -i ${IMG_PATH}
else
    /bin/i3lock -e -f -k -t -i ${IMG_PATH}
fi
