#!/bin/bash
# Install all packages using pacman

to_install=$(cat pkglist_pacman.txt | egrep -E "^[[:alnum:]].*")
pacman -S ${to_install}
