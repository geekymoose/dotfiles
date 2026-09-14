#!/bin/bash
# Mirror tofu diskdata to backup disk

source "${HOME}/.config/sh/functions.sh"

SRC="/mnt/diskdata/sync/tofu"
DST="/run/media/veracrypt1/sync/tofu"
SYNC_FILE="/run/media/veracrypt1/sync/last_sync.txt"

ensure_on_hostname "carrot"

run_rsync_backup "${SRC}" "${DST}"

if [ $? -eq 0 ]; then
    sed -i "s/tofu.*/tofu $(date)/g" ${SYNC_FILE}
    log_success "[OK] Sync updated: ${SYNC_FILE}"
else
    log_error "[ERR] Sync failed, the ${SYNC_FILE} was not updated"
fi
