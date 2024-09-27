# ------------------------------------------------------------------------------
# Set of reusable utilities
# These are targetted to be used in shell scripts
# ------------------------------------------------------------------------------

export COLOR_ERROR='\e[31m'
export COLOR_SUCCESS='\033[32m'
export COLOR_CMD='\e[34m'
export COLOR_NORMAL='\e[0m'

# Execute the provided command, but prints the full cmd before executing it.
# Param 1: the command line to execute
function apply_cmd() {
    echo -e "${COLOR_CMD}${1}${COLOR_NORMAL}"
    eval $1
}

# Checks whether the provided command is installed
# Exit if is not installed
# Param 1: the command
function ensure_is_installed {
    cmdname="$1"
    which "$cmdname" >> /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo -e "${COLOR_ERROR}$cmdname not found${COLOR_NORMAL}"
        exit 42
    fi
}

# Checks whether the current hostname is equal to the expected one
# Exit if is not the expected value
# Param 1: the expected hostname
function ensure_on_hostname {
    expected_name="$1"
    if [[ $(hostname) != "$expected_name" ]]; then
        echo -e "${COLOR_ERROR}Action not allowed on this computer (only usable on ${expected_name})${COLOR_NORMAL}"
        exit 42
    fi
}

# Check key is plugged
function ensure_disklabel_exists {
    disk_label="$1"
    disk_exists=$(ls /dev/disk/by-label/ | grep -i $disk_label)
    if [ -z "${disk_exists}" ]; then
        echo -e "${COLOR_ERROR}[ERR] The partition with label \"$disk_label\" does not exists (make sure it is mounted)${COLOR_NORMAL}"
        exit 42
    fi
}

