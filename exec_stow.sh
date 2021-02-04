#!/bin/bash

for file in ./src/*; do
    echo -e "\e[34m---> Stowing package ${file##*/}\e[0m"
    stow --verbose=1 --no-folding --dir="./src" --target="$HOME" ${file##*/}
done
