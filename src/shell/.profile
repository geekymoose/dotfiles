# ~/.profile

umask 027 # By default, no perm for 'a' group (file: 640, folder: 750)

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"


which nvim >> /dev/null && EDITOR="/usr/bin/nvim" || EDITOR="/usr/bin/vim"
export EDITOR

which alacritty >> /dev/null && TERM="alacritty" || EDITOR=linux
export TERM

export VISUAL=$EDITOR
export BROWSER="firefox"

