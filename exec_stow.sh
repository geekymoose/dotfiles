#!/bin/bash
# Creates all symlinks

for dotfiles_src in ./src/*; do
    echo -e "\e[34m---> Stowing category: ${dotfiles_src}\e[0m"
    for file in ${dotfiles_src}/*; do
        echo -e "\e[34m---> Stowing package ${file##*/}\e[0m"
        stow --verbose=1 --no-folding --dir="${dotfiles_src}" --target="$HOME" ${file##*/}
    done
done
