#
# ~/.zprofile
#

# Load zshrc file if exists
[[ -f ~/.zshrc ]] && source ~/.zshrc


# Load external files
source "${HOME}/.config/shell/profile.sh"


# Display welcome text
cat "${HOME}/.config/shell/prompt.txt"
