# ------------------------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------------------------

# AddToPath function
AddToPath(){
    [[ $# < 1 ]] && echo "Too few argument." && return;
    [[ $# > 1 ]] && echo "Too many argument." && return;
    [[ ! -d "$1" ]] && echo "$1 is not a directory." && return;
    [[ "${PATH#*$1}" = "$PATH" ]] && PATH=$1:$PATH
}


# Update PATH
AddToPath "$HOME/.local/bin"


# Use vim or nvim if detected
EDITOR="/usr/bin/vim"
which nvim >> /dev/null && EDITOR="/usr/bin/nvim"
export EDITOR


# Set default terminal
TERMINAL="urxvt"
export TERMINAL
