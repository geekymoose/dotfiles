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

ensure_folder_exists "${DISKDATA}"
ensure_is_installed "exiv2"
ensure_is_installed "fd"

# Lookup for files with the provided extension (case-sensitive).
# Reports any matches found.
# Parameters:
#   $1 - The extension to check (e.g. "jpg", "md")
function check_extension() {
    local description="${1}"
    local search_pattern=".*\.${1}$"
    log_info "---> LOOKUP for extension: ${description}"
    fd -HIs \
        --search-path "${DISKDATA}" \
        --regex "${search_pattern}" \
        --exclude "_inbox/"
}

# Lookup for files matching the provided regex pattern.
# Reports any matches found.
# Parameters:
#   $1 - The description of the pattern (to display in the log)
#   $2 - The regex pattern to match (e.g. ".*\.jpg$")
function check_pattern() {
    local description="${1}"
    local search_pattern="${2}"
    log_info "---> LOOKUP for pattern: ${description}"
    fd -HIi \
        --search-path "${DISKDATA}" \
        --regex "${search_pattern}" \
        --exclude "_inbox/"
}

# Lookup for missing "DateTimeOriginal" metadata in image files.
# Reports errors and generates a batch command to fix missing metadata.
# Parameters:
#   $1 - The file to check (must be a file, not a directory).
# Returns:
#   0 on success, 1 if the input is invalid or metadata is missing.
function check_missing_metadata_datetimeoriginal() {
    local file="$1"
    local datetime_metadata
    local datetime_naming

    if [[ -d "$file" ]]; then
        log_error "Invalid parameter (must be a file, not a directory): $file"
        return 0
    fi

    datetime_metadata_fetched=$(exiv2 -K "Exif.Photo.DateTimeOriginal" -Pv "$file" 2>/dev/null)
    if [[ -z "$datetime_metadata_fetched" ]]; then
        log_error "Missing DateTimeOriginal metadata in file: $file"

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
# Reports errors and generates a batch command to rename files with mismatched metadata.
# Parameters:
#   $1 - The file to check (must be a file, not a directory).
# Returns:
#   0 on success, 1 if the input is invalid or metadata does not match the filename.
function check_invalid_filename_datetimeoriginal() {
    local file="$1"
    local datetime_metadata
    local datetime_naming

    if [[ -d "$file" ]]; then
        log_error "Invalid parameter (must be a file, not a directory): $file"
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
        log_error "Metadata DateTimeOriginal ($datetime_metadata) does not match filename date ($datetime_naming): $file"

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
log_info "---> LOOKUP for hidden files and directories"
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
log_info "---> LOOKUP for filename with spaces"
fd -HIi -t f --search-path ${DISKDATA} --regex "^ "
fd -HIi -t f --search-path ${DISKDATA} --regex " $"
fd -HIi -t f --search-path ${DISKDATA} --regex ".* .*" \
    --exclude "builds/**/unity default resources" \
    --exclude "notes"

# Only lowercase characters are allowed in filenames
log_info "---> LOOKUP for filename with uppercase (only lowercase allowed)"
fd -HIs --search-path ${DISKDATA} --regex ".*[[:upper:]].*" \
    --exclude "_inbox" \
    --exclude "builds" \
    --exclude "notes" \
    --exclude "sources" \
    --exclude "setup/**/.git/" \
    --exclude "setup/**/PKGBUILD" \
    --exclude "setup/**/.SRCINFO"

# Only alpha-numeric characters in filenames (no accent etc)
# This allows spaces because it checks in folders that allow them
log_info "---> LOOKUP for filename with special characters (only alpha-numeric characters)"
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
log_info "---> LOOKUP for wrong permissions"
fd -HIi -t x --search-path ${DISKDATA} \
    --exclude "builds" \
    --exclude "sources" \
    --exclude "setup"
fd -i -t x --search-path ${DISKDATA}/sources \
    --exclude "extern" \
    --exclude "*.sh"

# Report image that are missing "DateTimeOriginal" metadata
export -f check_missing_metadata_datetimeoriginal
log_info "---> LOOKUP for missing jpg metadata (DateTimeOriginal))"
fd -HIi --extension jpg --search-path ${DISKDATA}/media/ \
    --exclude "art" \
    --exec bash -c 'check_missing_metadata_datetimeoriginal "$1"' _ {}

# Report image that are missing "DateTimeOriginal" metadata
export -f check_invalid_filename_datetimeoriginal
log_info "---> LOOKUP for invalid jpg metadata (DateTimeOriginal should match filename))"
fd -HIi --extension jpg --search-path ${DISKDATA}/media/ \
    --exclude "art" \
    --exec bash -c 'check_invalid_filename_datetimeoriginal "$1"' _ {}
