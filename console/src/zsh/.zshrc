#
# ~/.zshrc
#

# User specific config (common with all shells)
if [ -d ~/.config/sh.d ]; then
    for rc in ~/.config/sh.d/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
    unset rc
fi


# ------------------------------------------------------------------------------
# Miscs
# ------------------------------------------------------------------------------

# Color
autoload -Uz colors
colors

# Setup prompt
autoload -Uz promptinit
promptinit
PROMPT="%{$fg[magenta]%}[%{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[green]%}%m%{$fg[magenta]%}]%{$fg[cyan]%}$ %{$reset_color%}"
RPROMPT="%{$fg[magenta]%}[%{$fg[yellow]%}%~%{$fg[magenta]%}]%{$reset_color%}"

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' rehash true # Automatic rehash call
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
setopt COMPLETE_ALIASES

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=42
SAVEHIST=42

# Help (not present by default in zsh)
autoload -Uz run-help
alias help=run-help
autoload -Uz run-help-git


# ------------------------------------------------------------------------------
# Shortcuts
# ------------------------------------------------------------------------------

# Keys
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

# Bindings
bindkey -e # Emacs like mode

# Setup key
[[ -n "${key[Home]}" ]]         && bindkey "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]]          && bindkey "${key[End]}" end-of-line
[[ -n "${key[Insert]}" ]]       && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]]       && bindkey "${key[Delete]}" delete-char
[[ -n "${key[PageDown]}" ]]     && bindkey "${key[PageDown]}" down-line-or-history
[[ -n "${key[PageUp]}" ]]       && bindkey "${key[PageUp]}" up-line-or-search


# ------------------------------------------------------------------------------
# Pluggins
# ------------------------------------------------------------------------------

# Theme powerlevel10k https://github.com/romkatv/powerlevel10k#get-started
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use fish-like syntax highlighting (if fish installed)
# https://github.com/zsh-users/zsh-syntax-highlighting
FISH_SYNTAX_DIR='/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
source $FISH_SYNTAX_DIR
