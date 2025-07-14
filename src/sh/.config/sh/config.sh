# ------------------------------------------------------------------------------
# Custom configuration
# ------------------------------------------------------------------------------

umask 027 # By default, no perm for 'a' group (file: 640, folder: 750)

# SSH
# Make sure that only one ssh-agent process runs at a time
# See https://wiki.archlinux.org/index.php/ssh_keys (section ssh-agent)
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
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

# YAZI
# Change the current working directory when exiting Yazi
# See https://yazi-rs.github.io/docs/quick-start
function yazi() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    /usr/bin/yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
