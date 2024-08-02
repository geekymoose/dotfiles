# ------------------------------------------------------------------------------
# Miscs utilities
# ------------------------------------------------------------------------------

umask 027 # By default, no perm for 'a' group (file: 640, folder: 750)


# SSH
# Make sure that only one ssh-agent process runs at a time
# See https://wiki.archlinux.org/index.php/ssh_keys (section ssh-agent)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi


# RANGER
# Preventing nested ranger instances
# See https://wiki.archlinux.org/index.php/Ranger
function ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

