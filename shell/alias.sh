# ------------------------------------------------------------------------------
# ALIAS
# ------------------------------------------------------------------------------
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias rm='rm -i'
alias ip='ip -c'
alias grep='grep --color=auto'
alias emacs='emacs -nw'

# Conditional aliases (Alias only if exists)
which nvim >> /dev/null && alias vim='nvim'
