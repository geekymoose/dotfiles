#!/bin/bash
# Install all packages for archlinux (using pacman)

to_install=$(cat pkglist.txt | egrep -E "^[[:alnum:]].*")
pacman -S ${to_install}
