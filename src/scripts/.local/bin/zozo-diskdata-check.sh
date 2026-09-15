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

export -f log_error
export -f log_success
export -f log_info
export -f log_normal

export DISKDATA=/mnt/diskdata
export LOGDIR=${HOME}/downloads/

ensure_folder_exists "${DISKDATA}"
ensure_is_installed "exiv2"
ensure_is_installed "fd"

# Lookup for files with the provided extension (case-sensitive).
# Reports any matches found.
# Parameters:
#   $1 - The extension to check (e.g. "jpg", "md")
function find_extension() {
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
function find_pattern() {
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
function find_missing_metadata_datetimeoriginal() {
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
        echo "exiv2 -M\"set Exif.Photo.DateTimeOriginal ${new_datetime_metadata}\" \"${file}\"" >>"${LOGDIR}/update_batch_commands.sh"
    fi
}

# Lookup for mismatched "DateTimeOriginal" metadata and filename suffix YYYY-MM-DD.
# Reports errors and generates a batch command to rename files with mismatched metadata.
# Parameters:
#   $1 - The file to check (must be a file, not a directory).
# Returns:
#   0 on success, 1 if the input is invalid or metadata does not match the filename.
function find_invalid_filename_datetimeoriginal() {
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
        new_filename="$(dirname "$file")/${datetime_metadata}${filename:17}"
        echo "mv -v \"$file\" \"${new_filename}\"" >>"${LOGDIR}/rename_batch_commands.sh"

        return 1
    fi
}

function find_invalid_photo_prefix() {
    local file="$1"
    local old_filename
    local new_filename
    local extension
    local parent_dir_path
    local parent_dir_name
    local date_prefix
    local folder_name

    if [[ -d "$file" ]]; then
        log_error "Invalid parameter (must be a file, not a directory): $file"
        return 0
    fi

    old_filename=$(basename "$file")
    extension="${old_filename##*.}"
    parent_dir_path=$(dirname "$file")
    parent_dir_name=$(basename "$parent_dir_path")

    # Check if parent directory name starts with a date (YYYY-MM-DD_ or YYYY_)
    if [[ "$parent_dir_name" =~ ^([0-9]{4}-[0-9]{2}-[0-9]{2}_)|([0-9]{4}_) ]]; then
        # Extract date prefix and folder name
        date_prefix="${BASH_REMATCH[0]}"
        folder_name="${parent_dir_name#"$date_prefix"}"
    else
        folder_name="$parent_dir_name"
    fi

    # Check if filename ends with the folder name
    if [[ "$old_filename" != *"$folder_name"* ]]; then
        new_filename="${old_filename%.*}_${folder_name}.${extension}"
        log_error "${file} (should end with ${folder_name})"
        echo "mv -v \"$file\" \"${parent_dir_path}/${new_filename}\"" >>"${LOGDIR}/rename_photos_suffix_commands.sh"
    fi
}

# ------------------------------------------------------------------------------
# Check extension types
# ------------------------------------------------------------------------------

# Only lowercase extensions are allowed.
find_extension "GIF"
find_extension "JPEG"
find_extension "jpeg"
find_extension "JPG"
find_extension "MKV"
find_extension "MP3"
find_extension "MP4"
find_extension "OGG"
find_extension "PDF"
find_extension "PNG"
find_extension "WAV"
find_extension "WEBM"
find_extension "WMV"

# Files in the notes directory should only be markdown (end with .md)
fd -HIi --type f --search-path "${DISKDATA}/notes" --regex '.*[^m][^d]$' \
    --exclude ".obsidian" \
    --exclude "DATA"

# ------------------------------------------------------------------------------
# Check special files
# ------------------------------------------------------------------------------

# Temporary files are not allowed.
find_pattern "~" ".*~$"
find_pattern ".Temp" "\.Temp$"
find_pattern ".*_grim.*" "_grim\."
find_pattern "screenshot_" "^screenshot_"

# Hidden files and hidden directories are not allowed.
log_info "---> LOOKUP for hidden files and directories"
fd -HIs --search-path ${DISKDATA} --regex "^\..*" \
    --exclude "notes/.obsidian" \
    --exclude "sources/" \
    --exclude "setup/"

# ------------------------------------------------------------------------------
# Check date formats
# ------------------------------------------------------------------------------

# Files prefixed with date must follow the "YYYY-MM-DD_HHMMSS" convention (ISO_8601)
find_pattern \
    "00000000_00h00m00s*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{2}h[[:digit:]]{2}m[[:digit:]]{2}s.*"
find_pattern \
    "00000000_000000*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{6}.*"
find_pattern \
    "00000000_000000000*" \
    "^[[:digit:]]{8}[_-][[:digit:]]{6}.*"
find_pattern \
    "*0000-00-00_000000000*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}_[[:digit:]]{9}.*"
find_pattern \
    "*0000-00-00_00-00-00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}.*"
find_pattern \
    "*0000_00-00*" \
    "[[:digit:]]{4}_[[:digit:]]{2}[_-][[:digit:]]{2}.*"
find_pattern \
    "*0000-00_00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}_[[:digit:]]{2}.*"
find_pattern \
    "*0000-00-00-*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}-.*"
find_pattern \
    "*0000-00-00_00-00-00*" \
    "[[:digit:]]{4}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}[_-][[:digit:]]{2}.*"

# ------------------------------------------------------------------------------
# Check filename characters
# ------------------------------------------------------------------------------

# No space allowed in filenames
log_info "---> LOOKUP for filename with spaces"
fd -HIi -t f --search-path ${DISKDATA} --regex "^ "
fd -HIi -t f --search-path ${DISKDATA} --regex " $"
fd -HIi -t f --search-path ${DISKDATA} --regex ".* .*" \
    --exclude "/builds/**/unity default resources" \
    --exclude "/notes/"

# Only lowercase characters are allowed in filenames
log_info "---> LOOKUP for filename with uppercase"
fd -HIs --search-path ${DISKDATA} --regex ".*[[:upper:]].*" \
    --exclude "/_inbox/" \
    --exclude "/builds/" \
    --exclude "/notes/" \
    --exclude "/sources/" \
    --exclude "/setup/**/.git/" \
    --exclude "/setup/**/PKGBUILD" \
    --exclude "/setup/**/.SRCINFO"

# Only alpha-numeric characters in filenames (no accent etc)
# This allows spaces because it checks in folders that allow them
log_info "---> LOOKUP for filename with special characters"
fd -s --search-path ${DISKDATA} --regex ".*[^\p{Han}a-zA-Z0-9 .()#+_-].*"

# ------------------------------------------------------------------------------
# Check metadata
# ------------------------------------------------------------------------------

# Executables are not allowed (exect in builds, setup, and sources)
log_info "---> LOOKUP for file with executable permissions"
fd -HIi -t x --search-path ${DISKDATA} \
    --exclude "/builds/" \
    --exclude "/sources/" \
    --exclude "/setup/"
fd -i -t x --search-path ${DISKDATA}/sources \
    --exclude "extern" \
    --exclude "*.sh"

# Files must have 640 permissions
log_info "---> LOOKUP for file (not executable) with permission different than 640"
fd -HIi -t f --search-path ${DISKDATA} \
    --exclude "/builds/" \
    --exclude "/sources/" \
    --exclude "/setup/" \
    --exec stat -c '%a %n' | rg -v '640'

# Directories must have 750 permissions
log_info "---> LOOKUP for directory with permission different than 750"
fd -HIi -t d --search-path ${DISKDATA} \
    --exclude "/builds/" \
    --exclude "/sources/" \
    --exclude "/setup/" \
    --exec stat -c '%a %n' | rg -v '750'

# All jpg file must have the "DateTimeOriginal" metadata
export -f find_missing_metadata_datetimeoriginal
log_info "---> LOOKUP for missing DateTimeOriginal metadata in jpg files"
fd -HIi --extension jpg --search-path ${DISKDATA}/media/ \
    --exclude "/art/" \
    --exec bash -c 'find_missing_metadata_datetimeoriginal "$1"' _ {}

# All jpg filename must be prefixed with the "DateTimeOriginal" metadata value
export -f find_invalid_filename_datetimeoriginal
log_info "---> LOOKUP for jpg filename that does not match the DateTimeOriginal value"
fd -HIi --extension jpg --search-path ${DISKDATA}/media/ \
    --exclude "/art/" \
    --exec bash -c 'find_invalid_filename_datetimeoriginal "$1"' _ {}

# ------------------------------------------------------------------------------
# Special rules
# ------------------------------------------------------------------------------

# Photo jpg must have a valid suffix (parent folder name) in the filename
export -f find_invalid_photo_prefix
log_info "---> LOOKUP for photos that do not follow the parent folder name"
fd -HIi -e jpg -e png --search-path "${DISKDATA}/media/" \
    --exclude "/art/" \
    --exclude "/gamejams/" \
    --exclude "/games/" \
    --exclude "/stravenart/" \
    --exec bash -c 'find_invalid_photo_prefix "$1"' _ {}
