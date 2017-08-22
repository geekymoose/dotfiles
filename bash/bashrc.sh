# ******************************************************************************
# BASH CONFIG FILE
# ~/.bashrc
# ******************************************************************************

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Include external files
. "${HOME}/.config/shell/alias.sh"
. "${HOME}/.config/shell/env.sh"
. "${HOME}/.config/shell/assets.sh"
. "${HOME}/.config/shell/theme.sh"

# Display welcome text
clear #Useful sometimes, like when c-S in ranger
cat "${HOME}/.config/shell/prompt.txt"
