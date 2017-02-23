#!/usr/bin/env bash

# This script is to print the hist of how much space the directories in the current working directory use

error () {
    echo "ERROR: $1"
    exit $2
} >&2

# Create a temp file
my_mktemp() {
    mktemp || mktemp -t hist
} 2> /dev/null

(( BASH_VERSINFO[0] < 4 )) && error "This script needs bash version 4 or higher" 1

declare -A file_sizes
declare -r tempfile=$(my_mktemp) || error "Cannot create temp file" 1

# How wide is the terminal
declare -ir term_cols=$(tput cols)

# Longest filename, largest file, and total file size
declare -i max_file_len=0 max_size=0 total_size=0

# draw a line func
drawline () {
    declare line=""
    declare char="-"
    for (( i=0; i<$1; ++i )); do
        line="${line}${char}"
    done
    printf "%s" "$line"
}

# This reads the output from du into an array
read_filesizes () {
    while read -r size name; do
        file_sizes["$name"]="$size"
        (( total_size += size ))
        (( max_size < size )) && (( max_size=size ))
        (( max_file_len < ${#name} )) && (( max_file_len=${#name} ))
    done
}

# run du to get filesizes
# Using a temp file for output from du
{ du -d 0 */ || du --max-depth 0 *; } 2>/dev/null > "$tempfile"
read_filesizes < "$tempfile"

# The length for each line and percentage for each file
declare -i length percentage
# How many cols may the lines take up?
declare -i cols="term_cols - max_file_len - 10"

for k in "${!file_sizes[@]}"; do
    (( length=cols * file_sizes[$k] / max_size ))
    (( percentage=100*file_sizes[$k] / total_size ))
    printf "%-${max_file_len}s | %3d%% | %s\n" "$k" "$percentage" $(drawline $length)
done

printf "%d Directories\n" "${#file_sizes[@]}"
printf "Total Size: %d blocks\n" "$total_size"

rm "$tempfile"
