#
# ~/.bash_profile
#

# Load bashrc file if exists
[[ -f ~/.bashrc ]] && . ~/.bashrc


# Load external files
. "${HOME}/.config/shell/profile.sh"
#


# Display welcome text
clear
cat "${HOME}/.config/shell/prompt.txt"
