#!/bin/bash
# Mirror tofu diskdata to backup disk

source "${HOME}/.config/sh/functions.sh"

SRC="/mnt/diskdata/tofu"
DST="/run/media/veracrypt1/tofu"
SYNC_FILE="/run/media/veracrypt1/last_sync.txt"

ensure_on_hostname "carrot"

run_rsync_backup "${SRC}" "${DST}"

if [ $? -eq 0 ]; then
    sed -i "s/tofu.*/tofu $(date)/g" ${SYNC_FILE}
    echo -e "${COLOR_SUCCESS}[OK] Sync updated: ${SYNC_FILE} ${COLOR_NORMAL}"
else
    echo -e "${COLOR_ERROR}[ERR] Sync failed, the ${SYNC_FILE} was not updated ${COLOR_NORMAL}"
fi
