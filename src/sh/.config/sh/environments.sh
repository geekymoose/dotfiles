# ------------------------------------------------------------------------------
# Environments
# ------------------------------------------------------------------------------

export PATH="$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export EDITOR=nvim
export VISUAL=nvim

export TERMINAL=alacritty
export TERM=alacritty
export BROWSER=firefox

# Color in man page
# See https://wiki.archlinux.org/title/color_output_in_console#man
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# QT config for all environments (see https://wiki.archlinux.org/title/qt#gtk_and_qt)
export QT_QPA_PLATFORMTHEME=qt6ct
