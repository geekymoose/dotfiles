#!/bin/bash
# Mount the diskdata partition (/mnt/diskdata)

source "${HOME}/.config/sh/functions.sh"

if [[ $(hostname) == "carrot" ]]; then
    run_mount_luks "diskdata" "/dev/nvme0n1p5" "/mnt/diskdata"
elif [[ $(hostname) == "tofu" ]]; then
    run_mount_luks "diskdata" "/dev/nvme0n1p8" "/mnt/diskdata"
fi
