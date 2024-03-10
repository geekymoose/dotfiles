# ~/.zshrc

# User specific config (common to all shells)
if [ -d ~/.config/sh ]; then
    for rc in ~/.config/sh/*; do
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

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' rehash true # Automatic rehash call
zstyle ':completion:*' menu select

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=42
SAVEHIST=42

# Help (not present by default in zsh)
autoload -Uz run-help
autoload -Uz run-help-git
alias help=run-help

# Keys
bindkey -e


# ------------------------------------------------------------------------------
# Pluggins
# ------------------------------------------------------------------------------

# Theme powerlevel10k https://github.com/romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use fish-like syntax highlighting (if fish installed)
# https://github.com/zsh-users/zsh-syntax-highlighting
FISH_SYNTAX_DIR='/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
source $FISH_SYNTAX_DIR
