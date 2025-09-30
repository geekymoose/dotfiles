#!/bin/bash
# Mount the diskdata partition (/mnt/diskdata)

function mount_diskdata()
{
    local diskpath=$1
    echo "Mounting ${diskpath} to diskdata ..."

    $(mountpoint -q "/mnt/diskdata/")
    if [[ $? -eq 0 ]]
    then
        echo "Diskdata is already mounted (nothing is done)"
        return 0
    else
        echo "Diskdata is not already mounted, running the encryption mount"
        sudo cryptsetup luksOpen ${diskpath} diskdata
        sudo mount /dev/mapper/diskdata /mnt/diskdata
        return 0
    fi
}

if [[ $(hostname) == "carrot" ]]; then
    mount_diskdata "/dev/nvme0n1p5"
elif [[ $(hostname) == "tofu" ]]; then
    mount_diskdata "/dev/nvme0n1p8"
fi
