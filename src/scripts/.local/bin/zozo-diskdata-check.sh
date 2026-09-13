#!/bin/bash
#
# Checks if files in the diskdata partition conform to naming convention rules.
# These rules ensure consistency and organization across the diskdata partition.
# The script reports files with:
#
# - Non-standard extensions
# - Invalid naming patterns
# - Spaces in filenames
# - Uppercase in filenames
# - Incorrect permissions
# - Temporary files
#
# Regex syntax: https://docs.rs/regex/1.0.0/regex/#syntax

source "${HOME}/.config/sh/functions.sh"
DISKDATA=/mnt/diskdata

# Lookup for files with the provided extension.
# The search is case sensitive.
# Reports any matches found.
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

# Lookup for files matching the provided regex pattern.
# Reports any matches found.
function check_pattern() {
    description="${1}"
    search_pattern="${2}"
    echo -e "${COLOR_INFO}---> LOOKUP for pattern: ${description}"
    fd -HIi \
       --search-path ${DISKDATA} \
       --regex "${search_pattern}" \
       --exclude "_inbox/" \
       --exclude ".Trash-1000"
}


# ------------------------------------------------------------------------------
# Check extension types
# ------------------------------------------------------------------------------

# Lookup non-standard file extensions (only lowercase accepted)
check_extension "GIF"
check_extension "JPEG"
check_extension "jpeg"
check_extension "JPG"
check_extension "MKV"
check_extension "MP3"
check_extension "MP4"
check_extension "OGG"
check_extension "PDF"
check_extension "PNG"
check_extension "WAV"
check_extension "WEBM"
check_extension "WMV"


# ------------------------------------------------------------------------------
# Check special files
# ------------------------------------------------------------------------------

# Loopup temporary files (not allowed)
check_pattern "~" ".*~$"
check_pattern ".Temp" "\.Temp$"
check_pattern ".*_grim.*" "_grim\."
check_pattern "screenshot_" "^screenshot_"

# Lookup hidden files and directories (not allowed)
echo -e "---> LOOKUP for hidden files and directories"
fd -HIs --search-path ${DISKDATA} --regex "^\..*" \
    --exclude "notes/.obsidian" \
    --exclude "sources/" \
    --exclude "setup/"


# ------------------------------------------------------------------------------
# Check image naming rules
# ------------------------------------------------------------------------------

# Non-standard image naming patterns
# Expected format: "YYYY-MM-DD_HHMMSS" naming convention
check_pattern \
    "00000000_00h00m00s*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{2}h[[:digit:]]{2}m[[:digit:]]{2}s.*"
check_pattern \
    "00000000_000000*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{6}.*"
check_pattern \
    "00000000_000000000*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{6}.*"
check_pattern \
    "*0000-00-00_000000000*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}_[[:digit:]]{9}.*"
check_pattern \
    "*0000-00-00_00-00-00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}.*"
check_pattern \
    "*0000_00-00*" \
    "[[:digit:]]{4}_[[:digit:]]{2}[_-][[:digit:]]{2}.*"
check_pattern \
    "*0000-00_00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}_[[:digit:]]{2}.*"
check_pattern \
    "*0000-00-00-*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}-.*"
check_pattern \
    "*0000-00-00_00-00-00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}.*"


# ------------------------------------------------------------------------------
# Check general naming rules
# ------------------------------------------------------------------------------

# No space allowed in filenames
echo -e "---> LOOKUP for filename with spaces"
fd -HIi -t f --search-path ${DISKDATA} --regex "^ "
fd -HIi -t f --search-path ${DISKDATA} --regex " $"
fd -HIi -t f --search-path ${DISKDATA} --regex ".* .*" \
    --exclude "builds/**/unity default resources" \
    --exclude "notes"

# Only lowercase characters are allowed in filenames
echo -e "---> LOOKUP for filename with uppercase (only lowercase allowed)"
fd -HIs --search-path ${DISKDATA} --regex ".*[[:upper:]].*" \
    --exclude "_inbox" \
    --exclude "builds" \
    --exclude "notes" \
    --exclude "sources" \
    --exclude "setup/**/.git/" \
    --exclude "setup/**/PKGBUILD" \
    --exclude "setup/**/.SRCINFO"

# Only alpha-numeric characters in filenames (no accent etc)
# This allows spaces because it check in folders that allow them
echo -e "---> LOOKUP for filename with special characters (only alpha-numeric characters)"
fd -s --search-path ${DISKDATA} --regex ".*[^\p{Han}a-zA-Z0-9 .()#+_-].*"

# Note files should only be markdown (end with .md)
fd -HIi --type f --search-path "${DISKDATA}/notes" --regex '.*[^m][^d]$' \
    --exclude ".obsidian" \
    --exclude "DATA"


# ------------------------------------------------------------------------------
# Check metadata
# ------------------------------------------------------------------------------

# Check for wrong permission.
# The "other" permissions should be 0 for any file and folder.
echo "Check file permission"
fd -HIi -t x --search-path ${DISKDATA} \
    --exclude "builds" \
    --exclude "sources" \
    --exclude "setup"
fd -i -t x --search-path ${DISKDATA}/sources \
    --exclude "extern" \
    --exclude "*.sh"
