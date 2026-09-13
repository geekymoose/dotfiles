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

export DISKDATA=/mnt/diskdata
export LOGDIR=${HOME}/downloads/

# Check if DISKDATA is a valid directory
if ! [[ -d ${DISKDATA} ]]; then
    echo -e "${COLOR_ERROR}Error: ${DISKDATA} is not a valid directory. Make sure it is mounted and accessible."
    exit 1
fi
# Check if exiv2 is installed
if ! command -v exiv2 &>/dev/null; then
    echo -e "${COLOR_ERROR}Error: exiv2 is not installed. Install it with 'sudo pacman -S exiv2'"
    exit 1
fi
# Check if fd is installed
if ! command -v fd &>/dev/null; then
    echo -e "${COLOR_ERROR}Error: fd is not installed. Install it with 'sudo pacman -S fd'"
    exit 1
fi

# Lookup for files with the provided extension.
# The search is case sensitive.
# Reports any matches found.
# Parameters:
# 1. The extension to check (e.g. "jpg", "md")
function check_extension() {
    description="${1}"
    search_pattern=".*\.${1}$"
    echo -e "${COLOR_INFO}---> LOOKUP for extension: ${description}"
    fd -HIs \
        --search-path ${DISKDATA} \
        --regex "${search_pattern}" \
        --exclude "_inbox/"
}

# Lookup for files matching the provided regex pattern.
# Reports any matches found.
# Parameters:
# 1. The description of the pattern (to display in the log)
# 2. The regex pattern to match (e.g. ".*\.jpg$")
function check_pattern() {
    description="${1}"
    search_pattern="${2}"
    echo -e "${COLOR_INFO}---> LOOKUP for pattern: ${description}"
    fd -HIi \
        --search-path ${DISKDATA} \
        --regex "${search_pattern}" \
        --exclude "_inbox/"
}

# Lookup for missing "DateTimeOriginal" metadata.
# Reports any errors.
# Parameters:
# 1. The file to check (should be a file, not a directory)
function check_missing_metadata_datetimeoriginal() {
    local file="$1"
    local datetime_metadata
    local datetime_naming

    if [[ -d "$file" ]]; then
        echo -e "${COLOR_ERROR}Invalid parameter (must be a file, not a directory): $file" >&2
        return 0
    fi

    datetime_metadata_fetched=$(exiv2 -K "Exif.Photo.DateTimeOriginal" -Pv "$file" 2>/dev/null)
    if [[ -z "$datetime_metadata_fetched" ]]; then
        echo -e "${COLOR_ERROR}Missing DateTimeOriginal metadata in file: $file" >&2

        # Extract date from filename (YYYY-MM-DD_HHMMSS)
        filename=$(basename "$file")
        datetime_naming="${filename:0:17}" # Extract YYYY-MM-DD_HHMMSS (remove seconds)

        # Convert YYYY-MM-DD_HHMMSS to YYYY:MM:DD HH:MM:SS
        new_datetime_metadata="${datetime_naming:0:4}:${datetime_naming:5:2}:${datetime_naming:8:2} ${datetime_naming:11:2}:${datetime_naming:13:2}:${datetime_naming:15:2}"

        # And Build a batch exiv2 command file
        echo "exiv2 -M\"set Exif.Photo.DateTimeOriginal ${new_datetime_metadata}\" \"${file}\"" >>${LOGDIR}/update_batch_commands.sh
    fi

}

# Lookup for mismatched "DateTimeOriginal" metadata and filename suffix YYYY-MM-DD.
# Reports any errors.
# Parameters:
# 1. The file to check (should be a file, not a directory)
function check_invalid_filename_datetimeoriginal() {
    local file="$1"
    local datetime_metadata
    local datetime_naming

    if [[ -d "$file" ]]; then
        echo -e "${COLOR_ERROR}Invalid parameter (must be a file, not a directory): $file" >&2
        return 0
    fi

    # Extract DateTimeOriginal metadata
    datetime_metadata_fetched=$(exiv2 -K "Exif.Photo.DateTimeOriginal" -Pv "$file" 2>/dev/null)
    if [[ -z "$datetime_metadata_fetched" ]]; then
        return 0
    fi
    # Convert YYYY:MM:DD hh:mm:ss to YYYY-MM-DD_hhmmss
    datetime_metadata=${datetime_metadata_fetched:0:4}-${datetime_metadata_fetched:5:2}-${datetime_metadata_fetched:8:2}_${datetime_metadata_fetched:11:2}${datetime_metadata_fetched:14:2}${datetime_metadata_fetched:17:2}

    # Extract date from filename (YYYY-MM-DD_HHMMSS)
    filename=$(basename "$file")
    datetime_naming="${filename:0:17}" # Extract YYYY-MM-DD_HHMMSS (remove seconds)

    # Compare metadata date with filename date
    if [[ "$datetime_metadata" != "$datetime_naming" ]]; then
        echo -e "${COLOR_ERROR}Metadata DateTimeOriginal ($datetime_metadata) does not match filename date ($datetime_naming): $file"

        # Build a batch mv command file
        new_file="$(dirname "$file")/${datetime_metadata}${filename:17}"
        echo "mv -v \"$file\" \"${new_file}\"" >>${LOGDIR}/rename_batch_commands.sh

        return 1
    fi
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
echo -e "${COLOR_INFO}---> LOOKUP for hidden files and directories"
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
echo -e "${COLOR_INFO}---> LOOKUP for filename with spaces"
fd -HIi -t f --search-path ${DISKDATA} --regex "^ "
fd -HIi -t f --search-path ${DISKDATA} --regex " $"
fd -HIi -t f --search-path ${DISKDATA} --regex ".* .*" \
    --exclude "builds/**/unity default resources" \
    --exclude "notes"

# Only lowercase characters are allowed in filenames
echo -e "${COLOR_INFO}---> LOOKUP for filename with uppercase (only lowercase allowed)"
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
echo -e "${COLOR_INFO}---> LOOKUP for filename with special characters (only alpha-numeric characters)"
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
echo -e "${COLOR_INFO}---> LOOKUP for wrong permissions"
fd -HIi -t x --search-path ${DISKDATA} \
    --exclude "builds" \
    --exclude "sources" \
    --exclude "setup"
fd -i -t x --search-path ${DISKDATA}/sources \
    --exclude "extern" \
    --exclude "*.sh"

# Report image that are missing "DateTimeOriginal" metadata
export -f check_missing_metadata_datetimeoriginal
echo -e "${COLOR_INFO}---> LOOKUP for missing jpg metadata (DateTimeOriginal))"
fd -HIi --extension jpg --search-path ${DISKDATA}/media/ \
    --exclude "art" \
    --exec bash -c 'check_missing_metadata_datetimeoriginal "$1"' _ {}

# Report image that are missing "DateTimeOriginal" metadata
export -f check_invalid_filename_datetimeoriginal
echo -e "${COLOR_INFO}---> LOOKUP for invalid jpg metadata (DateTimeOriginal should match filename))"
fd -HIi --extension jpg --search-path ${DISKDATA}/media/ \
    --exclude "art" \
    --exec bash -c 'check_invalid_filename_datetimeoriginal "$1"' _ {}
