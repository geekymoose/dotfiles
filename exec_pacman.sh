#!/bin/bash
# Install all packages using pacman

category="$1"
if [ -z "$category" ]; then
    echo -e "\e[31mYou must provide a category to stow (archlinux, console, or programming)\e[0m"
    exit 42
fi

to_install=$(cat ${category}/pkglist.txt | egrep -E "^[[:alnum:]].*")
pacman -S ${to_install}
