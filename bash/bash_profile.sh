# ******************************************************************************
# BASH CONFIG FILE
# ~/.bash_profile
# ******************************************************************************

# Load bashrc file if exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Load external files
. "${HOME}/.config/shell/profile.sh"
