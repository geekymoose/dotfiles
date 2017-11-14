#
# ~/.zshrc
#
# zsh configuration.
#


# ------------------------------------------------------------------------------
# EXTERNAL SETTINGS (Include files)
# ------------------------------------------------------------------------------

# Include external files
source "${HOME}/.config/shell/alias.sh"
source "${HOME}/.config/shell/env.sh"
source "${HOME}/.config/shell/env-perso.sh"
source "${HOME}/.config/shell/assets.sh"
source "${HOME}/.config/shell/theme.sh"


# ------------------------------------------------------------------------------
# ZSH SPECIFIC SETTINGS
# ------------------------------------------------------------------------------

# Color
autoload -Uz colors
colors


# Setup prompt
autoload -Uz promptinit
promptinit
PROMPT="[%{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[green]%}%m%{$fg[magenta]%}]%{$fg[cyan]%}$ %{$reset_color%}"
RPROMPT="%{$fg[magenta]%}[%{$fg[yellow]%}%~%{$fg[magenta]%}]%{$reset_color%}"


# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' rehash true # Automatic rehash call
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
setopt COMPLETE_ALIASES


# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=40
SAVEHIST=40


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
bindkey -v # Vim like mode
bindkey  beginning-of-line
bindkey  end-of-line


# Setup key
[[ -n "${key[Home]}" ]]         && bindkey "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]]          && bindkey "${key[End]}" end-of-line
[[ -n "${key[Insert]}" ]]       && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]]       && bindkey "${key[Delete]}" delete-char
[[ -n "${key[PageDown]}" ]]     && bindkey "${key[PageDown]}" down-line-or-history
[[ -n "${key[PageUp]}" ]]       && bindkey "${key[PageUp]}" up-line-or-search


# Help (By default, not present in zsh)
autoload -Uz run-help
alias help=run-help
autoload -Uz run-help-git


# Use fish-like syntax highlighting (If fish installed)
FISH_SYNTAX_DIR='/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
if [[ -f $FISH_SYNTAX_DIR ]]; then
    source $FISH_SYNTAX_DIR
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)
    export ZSH_HIGHLIGHT_HIGHLIGHTERS
fi
