# ******************************************************************************
# ZSH CONFIG FILE
# ~/.zshrc
# ******************************************************************************


# ------------------------------------------------------------------------------
# EXTERNAL SETTINGS (Include files)
# ------------------------------------------------------------------------------
# Include external files
. "${HOME}/.config/shell/alias.sh"
. "${HOME}/.config/shell/env.sh"
. "${HOME}/.config/shell/assets.sh"
. "${HOME}/.config/shell/theme.sh"


# ------------------------------------------------------------------------------
# ZSH SPECIFIC SETTINGS
# ------------------------------------------------------------------------------

# Setup prompt
autoload -Uz promptinit
promptinit
PROMPT="[%{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[green]%}%m%{$fg[magenta]%}]%{$fg[cyan]%}$ %{$reset_color%}"
RPROMPT="%{$fg[magenta]%}[%{$fg[yellow]%}%~%{$fg[magenta]%}]%{$reset_color%}"

# Completion
autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=25
SAVEHIST=25

# Key setting
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Binding
bindkey  beginning-of-line
bindkey  end-of-line

# Setup key
[[ -n "${key[Home]}"      ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n "${key[End]}"     ]] && bindkey "${key[End]}" end-of-line
[[ -n "${key[Insert]}"  ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}"  ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[PageDown]}"  ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n "${key[PageUp]}"  ]] && bindkey "${key[PageUp]}" up-line-or-search


# Display welcome text
clear #Useful sometimes, like when c-S in ranger
cat "${HOME}/.config/shell/prompt.txt"
