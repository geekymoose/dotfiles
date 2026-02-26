#!/bin/bash
# Checks if a set of naming rules are satisfied in diskdata partition.
# These rules are required in my diskdata partition to ensure consistency and organization.
# Regex: https://docs.rs/regex/1.0.0/regex/#syntax

source "${HOME}/.config/sh/functions.sh"
DISKDATA=/mnt/diskdata

function check_extension() {
    description="${1}"
    search_pattern=".*\.${1}$"
    echo -e "${COLOR_INFO}---> LOOKUP for extension: ${description}"
    fd -HIs \
       --search-path ${DISKDATA} \
       --regex "${search_pattern}" \
       --exclude "_inbox/" \
       --exclude ".Trash-1000"
}

function check_image_pattern() {
    description="${1}"
    search_pattern="${2}"
    echo -e "${COLOR_INFO}---> LOOKUP for pattern: ${description}"
    fd -HIi \
       --search-path ${DISKDATA} \
       --regex "${search_pattern}" \
       --exclude "_inbox/" \
       --exclude ".Trash-1000"
}

check_extension "PNG"
check_extension "JPG"
check_extension "JPEG"
check_extension "jpeg"
check_extension "GIF"

check_extension "WAV"
check_extension "OGG"

check_extension "MP4"
check_extension "MP3"
check_extension "WEBM"
check_extension "WMV"
check_extension "MKV"

check_extension "PDF"

check_image_pattern "~" ".*~$"
check_image_pattern ".Temp" "\.Temp$"
check_image_pattern ".*_grim.*" "_grim"
check_image_pattern "screenshot_" "^screenshot_"

check_image_pattern \
    "00000000_00h00m00s*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{2}h[[:digit:]]{2}m[[:digit:]]{2}s.*"

check_image_pattern \
    "00000000_000000*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{6}.*"

check_image_pattern \
    "00000000_000000000*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{6}.*"

check_image_pattern \
    "*0000-00-00_000000000*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}_[[:digit:]]{9}.*"

check_image_pattern \
    "*0000-00-00_00-00-00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}.*"

check_image_pattern \
    "*0000_00-00*" \
    "[[:digit:]]{4}_[[:digit:]]{2}[_-][[:digit:]]{2}.*"

check_image_pattern \
    "*0000-00_00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}_[[:digit:]]{2}.*"

check_image_pattern \
    "*0000-00-00-*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}-.*"

check_image_pattern \
    "*0000-00-00_00-00-00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}.*"

# SPACES
echo -e "---> LOOKUP for filename with spaces (custom search paths)"
fd -HIi -t f --search-path ${DISKDATA} --regex "^ "
fd -HIi -t f --search-path ${DISKDATA} --regex " $"
fd -HIi -t f --search-path ${DISKDATA} --regex ".* .*" \
    --exclude "builds/**/unity default resources" \
    --exclude "notes" \
    --exclude "web"

# PERMS
echo "Check file permission (custom search path)"
fd -HIi -t x --search-path ${DISKDATA} \
    --exclude "builds" \
    --exclude "sources" \
    --exclude "setup"
fd -i -t x --search-path ${DISKDATA}/sources \
    --exclude "extern" \
    --exclude "*.sh"

# LOWERCASES
echo "Only lowercases (custom search path)"
fd -HIs --search-path ${DISKDATA} --regex ".*[[:upper:]].*" \
    --exclude "_inbox" \
    --exclude "builds" \
    --exclude "notes" \
    --exclude "sources" \
    --exclude "projects/**/README.md" \
    --exclude "projects/**/fmod/" \
    --exclude "setup/**/.git/" \
    --exclude "setup/**/PKGBUILD" \
    --exclude "setup/**/.SRCINFO" \
    --exclude "web"

# Hidden files
echo "Hidden files"
fd -HIs --search-path ${DISKDATA} --regex "^\..*" \
    --exclude "notes/.obsidian" \
    --exclude "sources/" \
    --exclude "projects/**/fmod" \
    --exclude "setup/"
