# ------------------------------------------------------------------------------
# Set of reusable functions
# These are mostly targetted to be used in my personal scripts
# To include in script: source "${HOME}/.config/sh/functions.sh"
# ------------------------------------------------------------------------------


COLOR_ERROR='\e[31m'
COLOR_SUCCESS='\033[32m'
COLOR_CMD='\e[34m'
COLOR_NORMAL='\e[0m'


# Executes the provided command, but prints the full cmd before executing it.
# For CI script, you may use `set -v` instead
# Param 1: the command line to execute
function apply_cmd() {
    echo -e "${COLOR_CMD}${1}${COLOR_NORMAL}"
    eval $1
}

# Returns a formatted version of date now (e.g., 2024-09-27_115031)
function formatted_date_now() {
    echo $(date +%F_%H%M%S)
}

# Checks whether the provided address is reachable
# Address should be fast reachable (sort timeout)
# Exit if not reachable
# Param 1: IP Address
function ensure_is_addr_reachable() {
    local addr="$1"
    echo "Trying to reach ${addr}..."
    ping -Dc 1 -w 1 $addr >> /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo -e "${COLOR_ERROR}[ERR] Unable to reach the requested address ${addr}${COLOR_NORMAL}"
        exit 42
    fi
}

# Checks whether the provided command is installed
# Exit if is not installed
# Param 1: the command
function ensure_is_installed {
    local cmdname="$1"
    which "$cmdname" >> /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo -e "${COLOR_ERROR}[ERR] Command \"$cmdname\" not found${COLOR_NORMAL}"
        exit 42
    fi
}

# Checks whether the current hostname is equal to the expected one
# Exit if is not the expected value
# Param 1: the expected hostname
function ensure_on_hostname {
    local expected_name="$1"
    if [[ $(hostname) != "$expected_name" ]]; then
        echo -e "${COLOR_ERROR}[ERR] Action not allowed on this computer (only usable on ${expected_name})${COLOR_NORMAL}"
        exit 42
    fi
}

# Checks if key with provided label is plugged
# Exit if not plugged
function ensure_disklabel_exists {
    local disk_label="$1"
    local disk_exists=$(ls /dev/disk/by-label/ 2> /dev/null | grep -i $disk_label 2> /dev/null )
    if [[ -z "${disk_exists}" ]]; then
        echo -e "${COLOR_ERROR}[ERR] The partition with label \"$disk_label\" does not exists (make sure it is mounted)${COLOR_NORMAL}"
        exit 42
    fi
}

# Checks if the folder exists
# Exit if doesn't exists
# Param 1: the folder full path
function ensure_folder_exists {
    local folderpath="$1"
    if ! [[ -d "$folderpath" ]]; then
        echo -e "${COLOR_ERROR}[ERR] The folder \"${folderpath}\" does not exists or is not a valid directory${COLOR_NORMAL}"
        exit 42
    fi
}

# Runs rsync backup (checks that src and dest are valid folders)
# Exist if invalid parameters
# Param 1: source folder
# Param 2: dest folder
function run_rsync_backup() {
    local src="$1"
    local dst="$2"
    ensure_folder_exists ${src}
    ensure_is_installed "rsync"

    echo "Running rsync backup..."
    echo " -> Source: ${src}"
    echo " -> Destination: ${dst}"

    # Run rsync and make sure we add prefix "/" (see documentation)
    apply_cmd "rsync -avr --delete ${src}/ ${dst}/"

    if [[ $? -eq 0 ]]; then
        echo -e "${COLOR_SUCCESS}[OK] Backup rsync successfully done${COLOR_NORMAL}"
    else
        echo -e "${COLOR_ERROR}[ERR] An error occured during the rsync${COLOR_NORMAL}"
        exit 42
    fi
}

# Runs adb-sync backup (checks that src and dest are valid folders)
# Exist if invalid parameters
# Param 1: source folder
# Param 2: dest folder
function run_adb_sync_backup() {
    local src="$1"
    local dst="$2"
    ensure_folder_exists ${src}
    ensure_is_installed "adb"
    ensure_is_installed "adb-sync"

    apply_cmd "adb devices"
    apply_cmd "adb-sync --delete ${SRC}/ ${DST}/"

    if [[ $? -eq 0 ]]; then
        echo -e "${COLOR_SUCCESS}[OK] Backup adb-sync successfully done${COLOR_NORMAL}"
    else
        echo -e "${COLOR_ERROR}[ERR] An error occured during the adb-sync${COLOR_NORMAL}"
        exit 42
    fi
}

