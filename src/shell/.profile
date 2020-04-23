# ~/.profile

umask 027 # By default, no perm for 'a' group (file: 640, folder: 750)

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

which nvim >> /dev/null && EDITOR="/usr/bin/nvim" || EDITOR="/usr/bin/vim"
export EDITOR
export TERM="alacritty"

