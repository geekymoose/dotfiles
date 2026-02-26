#!/bin/bash
# Mirror tofu diskdata to nox Raspberry

source "${HOME}/.config/sh/functions.sh"

SRC="/mnt/diskdata"
DST="/mnt/diskdata/tofu"
ADDR=192.168.1.121

ensure_on_hostname "tofu"
ensure_is_addr_reachable "$ADDR"

run_rsync_backup "${SRC}" "coco@${ADDR}:${DST}"
