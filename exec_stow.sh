#!/bin/bash
# Creates all symlinks

category="$1"
if [ -z "$category" ]; then
    echo -e "\e[31mYou must provide a category to stow (archlinux, console, or programming)\e[0m"
    exit 42
fi

echo -e "\e[34m---> Stowing dotfiles for: ${category}\e[0m"
for file in ${category}/src/*; do
    echo -e "\e[34m---> Stowing package ${file##*/}\e[0m"
    stow --verbose=1 --no-folding --dir="./${category}/src" --target="$HOME" ${file##*/}
done
