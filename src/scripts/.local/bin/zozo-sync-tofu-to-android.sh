#!/bin/bash
# Mirror tofu diskdata to android

source "${HOME}/.config/sh/functions.sh"

SRC="/mnt/diskdata"
DST="/sdcard/Android/disklocal/tofu"

ensure_on_hostname "tofu"

run_adb_sync_backup "${SRC}/documents" "${DST}/documents"
run_adb_sync_backup "${SRC}/media" "${DST}/media"
