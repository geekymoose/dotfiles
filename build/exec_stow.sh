#!/bin/bash
# Creates all symlinks (stow must be installed)

for file in ./src/*; do
    echo -e "\e[34m---> Stowing package ${file##*/}\e[0m"
    stow --verbose=1 --dir="./src" --target="$HOME" ${file##*/}
done
