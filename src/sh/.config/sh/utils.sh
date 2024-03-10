umask 027 # By default, no perm for 'a' group (file: 640, folder: 750)


# ------------------------------------------------------------------------------
# ssh-agent
# ------------------------------------------------------------------------------

## See https://wiki.archlinux.org/index.php/SSH_keys
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
[[ -f "$XDG_RUNTIME_DIR/ssh-agent.env" ]] && source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null


# ------------------------------------------------------------------------------
# Custom config
# ------------------------------------------------------------------------------

# See https://wiki.archlinux.org/index.php/Ranger
# Preventing nested ranger instances
function ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}
