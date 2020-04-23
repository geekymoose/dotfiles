# ~/.zprofile

# Load profile file if exists
[[ -f ~/.profile ]] && source ~/.profile

# Load zshrc file if exists
[[ -f ~/.zshrc ]] && source ~/.zshrc

# Start Xorg server according to logged terminal
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ]; then
    case $XDG_VTNR in
        1) startx ~/.xinitrc i3 ;;
        *) echo " * No xinit environment set for tty$XDG_VTNR";;
    esac
fi

