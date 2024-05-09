#!/bin/sh
# Run this script to clone the TMux plugin manager

if [[ -e tpm && -d tpm ]]; then
    echo "TPM plugin is already installed"
else
    git clone 'https://github.com/tmux-plugins/tpm'
fi

