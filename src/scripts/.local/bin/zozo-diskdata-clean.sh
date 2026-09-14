#!/bin/bash
#
# Attempt to fix issues reported by the diskdata check script.
# WARNING: to use only with care after a careful review of the issues reported.

source "${HOME}/.config/sh/functions.sh"

DISKDATA='/mnt/diskdata/'

# Cleanup all files and directories permissions
log_info "Cleaning ${DISKDATA} files and directories permissions"
TO_CLEAN="_inbox documents media notes resources web"
for folder in ${TO_CLEAN}; do
    current_path="${DISKDATA}/${folder}"
    log_info "---> ${current_path}"
    fd -HIi -t f --search-path "${current_path}" --exec chmod -v 640 {} \;
    fd -HIi -t d --search-path "${current_path}" --exec chmod -v 750 {} \;
done
log_success "${DISKDATA} files and directories permissions updated"
