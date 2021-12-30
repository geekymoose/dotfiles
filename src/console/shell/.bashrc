# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '


# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias rm='rm -i'
alias ip='ip -c'
alias grep='grep --color=auto'
alias emacs='emacs -nw'
alias vv='dirs -v'
which nvim >> /dev/null && alias vim='nvim'

