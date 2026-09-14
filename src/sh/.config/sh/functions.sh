# ------------------------------------------------------------------------------
# Set of reusable shell functions
# These are mostly targeted to be used in personal scripts.
# To include in script: source "${HOME}/.config/sh/functions.sh"
# ------------------------------------------------------------------------------

COLOR_ERROR='\e[31m'
COLOR_SUCCESS='\e[32m'
COLOR_INFO='\e[34m'
COLOR_NORMAL='\e[0m'

export COLOR_ERROR
export COLOR_SUCCESS
export COLOR_INFO
export COLOR_NORMAL

# Echo error (red)
function log_error() {
    echo -e "${COLOR_ERROR}$1${COLOR_NORMAL}"
}

# Echo success (green)
function log_success() {
    echo -e "${COLOR_SUCCESS}$1${COLOR_NORMAL}"
}

# Echo information (cyan)
function log_info() {
    echo -e "${COLOR_INFO}$1${COLOR_NORMAL}"
}

# Echo normal (default color)
function log_normal() {
    echo -e "${COLOR_NORMAL}$1${COLOR_NORMAL}"
}

# Executes the provided command after printing it.
#
# Returns the exit code of the command.
# Use `set -v` in CI scripts for verbose command logging.
#
# Param 1: command line to execute
function apply_cmd() {
    local cmd="$1"
    [[ -z "$cmd" ]] && {
        log_error "Empty command" >&2
        exit 42
    }

    log_info "${cmd}"
    bash -c "$cmd" || {
        log_error "Command failed: $cmd"
        exit 42
    }
}

# Returns current date in ISO 8601 format (e.g., 2024-09-27_115031).
function formatted_date_now() {
    date +%F_%H%M%S
}

# Checks if the provided address is reachable (1-second timeout).
# Exits with code 42 if unreachable.
#
# Param 1: IP address or hostname
function ensure_is_addr_reachable() {
    local addr="$1"
    [[ -z "$addr" ]] && {
        log_error "Empty address" >&2
        exit 42
    }
    log_info "Trying to reach ${addr}..."
    if ! ping -c 1 -W 1 "$addr" >>/dev/null 2>&1; then
        log_error "Unable to reach the requested address ${addr}"
        exit 42
    fi
}

# Checks if the provided command is installed.
# Exits with code 42 if not found.
#
# Param 1: command name to check
function ensure_is_installed() {
    local cmdname="$1"

    [[ -z "$cmdname" ]] && {
        log_error "Empty command name"
        exit 42
    }

    command -v "$cmdname" >/dev/null 2>&1 || {
        log_error "Command \"$cmdname\" not found"
        exit 42
    }
}

# Checks if the current hostname matches the expected value.
# Exits with code 42 if not.
#
# Param 1: expected hostname
function ensure_on_hostname() {
    local expected_name="$1"
    if [[ $(hostname) != "$expected_name" ]]; then
        log_error "Action not allowed on this computer (only usable on ${expected_name})"
        exit 42
    fi
}

# Checks if a disk with the provided label is plugged (case-insensitive).
# Exits with code 1 if not found.
#
# Requires: rg
# Param 1: disk label to check
function ensure_disklabel_exists() {
    ensure_is_installed "rg"

    local disk_label="$1"
    [[ -z "$disk_label" ]] && {
        log_error "Empty disk label"
        exit 42
    }

    if ! [[ -e "/dev/disk/by-label/${disk_label}" ]]; then
        log_error "The partition with label \"$disk_label\" does not exist (make sure it is mounted)"
        exit 42
    fi
}

# Checks if the folder exists.
# Exits with code 42 if not found or invalid.
#
# Param 1: folder full path
function ensure_folder_exists() {
    local folderpath="$1"
    if ! [[ -d "$folderpath" ]]; then
        log_error "The folder \"${folderpath}\" does not exist or is not a valid directory"
        exit 42
    fi
}

# Runs rsync backup (checks that source and destination folders are valid).
# Uses --delete to remove files in destination that are not in the source (mirror backup).
# Exits with code 42 on error.
#
# Param 1: source folder
# Param 2: destination folder
function run_rsync_backup() {
    local src="$1"
    local dst="$2"

    ensure_folder_exists "${src}"
    ensure_is_installed "rsync"

    log_info "Running rsync backup..."
    log_info " -> Source: ${src}"
    log_info " -> Destination: ${dst}"

    # Run rsync and make sure we add prefix "/" (see documentation)
    apply_cmd "rsync -avr --delete \"${src}/\" \"${dst}/\"" || {
        log_error "An error occurred during the rsync"
        exit 42
    }
    log_success "Backup rsync successfully done"
}

# Runs adb-sync backup (requires Android device connected via USB).
# Checks that source and destination folders are valid.
# Exits with code 42 on error.
#
# Param 1: source folder (on device)
# Param 2: destination folder (on host)
function run_adb_sync_backup() {
    local src="$1"
    local dst="$2"

    ensure_is_installed "adb"
    ensure_is_installed "adb-sync"
    ensure_folder_exists "${src}"

    apply_cmd "adb devices"
    apply_cmd "adb-sync --delete \"${src}/\" \"${dst}/\""

    if $? -ne 0; then
        log_error "Error during adb-sync"
        exit 42
    fi

    log_success "Backup adb-sync successfully done"
}

# Mounts a LUKS-encrypted partition (requires sudo).
# Checks if the partition is already mounted before proceeding.
# Exits with code 42 on error (e.g., invalid block device, mount failure).
#
# Param 1: name of the LUKS logical partition (e.g., diskdata)
# Param 2: source device path (e.g., /dev/sda1)
# Param 3: mount destination (e.g., /mnt/diskdata)
function run_mount_luks() {
    local name="$1"
    local src="$2"
    local dst="$3"

    ensure_is_installed "sudo"
    ensure_is_installed "cryptsetup"
    ensure_folder_exists "${dst}"

    log_info "Mounting ${src} to ${dst}..."

    if mountpoint -q "${dst}"; then
        log_success "Partition ${name} is already mounted (nothing is done)"
        return 0
    else
        log_info "Partition ${name} is not already mounted, running the encryption mount"

        sudo cryptsetup luksOpen "${src}" "${name}" || {
            log_error "LUKS open failed"
            exit 42
        }
        sudo mount "/dev/mapper/${name}" "${dst}" || {
            log_error "Mount failed"
            exit 42
        }
        return 0
    fi
}
