#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '


# Include external files
. "${HOME}/.config/shell/alias.sh"
. "${HOME}/.config/shell/env.sh"
. "${HOME}/.config/shell/assets.sh"
. "${HOME}/.config/shell/theme.sh"
