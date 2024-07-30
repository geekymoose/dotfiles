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

# Colors / Prompt / Completion
autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit

# ZStyle
zstyle ':completion:*' rehash true # Automatic rehash call
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/coco/.zshrc'

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100
SAVEHIST=100

# Help (not present by default in zsh)
autoload -Uz run-help
autoload -Uz run-help-git
alias help=run-help

# Keys
bindkey -v


# ------------------------------------------------------------------------------
# Pluggins
# ------------------------------------------------------------------------------

# Fish-like syntax and suggestions (zsh-syntax-highlighting and zsh-autosuggestions)
source '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
source '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh'

# OhMyZSH (https://github.com/ohmyzsh/ohmyzsh)
export ZSH="/usr/share/oh-my-zsh"
ZSH_THEME="jonathan"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

