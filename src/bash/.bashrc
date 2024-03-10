# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

# User specific config (common to all shells)
if [ -d ~/.config/sh ]; then
    for rc in ~/.config/sh/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
    unset rc
fi
