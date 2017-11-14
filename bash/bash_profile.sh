#
# ~/.bash_profile
#

# Load bashrc file if exists
[[ -f ~/.bashrc ]] && source ~/.bashrc


# Load external files
source "${HOME}/.config/shell/profile.sh"


# Display welcome text
clear
cat "${HOME}/.config/shell/prompt.txt"
