#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '


# Include external files
source "${HOME}/.config/shell/alias.sh"
source "${HOME}/.config/shell/env.sh"
source "${HOME}/.config/shell/env-perso.sh"
source "${HOME}/.config/shell/assets.sh"
source "${HOME}/.config/shell/theme.sh"
