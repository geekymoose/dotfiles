#!/bin/bash

to_install=$(cat pkglist.txt | egrep -E "^[[:alnum:]].*")
pacman -S ${to_install}
