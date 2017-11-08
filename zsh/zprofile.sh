#
# ~/.zprofile
#

# Load zshrc file if exists
[[ -f ~/.zshrc ]] && . ~/.zshrc


# Load external files
. "${HOME}/.config/shell/profile.sh"


# Display welcome text
cat "${HOME}/.config/shell/prompt.txt"
