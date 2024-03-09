#!/bin/sh

COLOR_CMD='\e[34m'
COLOR_NORMAL='\e[0m'

function apply_cmd() {
    echo -e "${COLOR_CMD}${1}${COLOR_NORMAL}"
    eval $1
}

# General
apply_cmd "rm -vfr ${HOME}/.cache"
apply_cmd "rm -vfr ${HOME}/.emacs.d/auto-save-list"
apply_cmd "rm -vfr ${HOME}/.thumbnails"
apply_cmd "rm -vf  ${HOME}/.*history"
apply_cmd "rm -vf  ${HOME}/.lesshst"
apply_cmd "rm -vf  ${HOME}/.*~"
apply_cmd "rm -vf  ${HOME}/*~"

# Gnus
apply_cmd "rm -vfr ${HOME}/Mail"
apply_cmd "rm -vfr ${HOME}/News"
apply_cmd "rm -vf  ${HOME}/.newsrc.eld"
apply_cmd "rm -vf  ${HOME}/.newsrc"