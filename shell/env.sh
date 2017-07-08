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
AddToPath "$HOME/.opam/system/bin"

EDITOR="/usr/bin/vim"
which nvim >> /dev/null && EDITOR="/usr/bin/nvim"
export EDITOR

# OPAM configuration
if (( ! $+OPAM_IS_INIT )); then
    export OPAM_IS_INIT=1
    . $HOME/.opam/opam-init/init.zsh > /dev/null 2>&1 || true
fi
