# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

# User specific config
if [ -d ~/.config/bashrc.d ]; then
    for rc in ~/.config/bashrc.d/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
    unset rc
fi
