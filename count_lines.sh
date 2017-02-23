#!/usr/bin/env bash

declare -i count=0

# Create a temp file
my_mktemp() {
    mktemp || mktemp -t hist
} 2> /dev/null

declare -r tempfile=$(my_mktemp) || error "Cannot create temp file" 1

count_lines () {
    while read -r || [ $REPLY ]; do
        (( ++count ))
    done
    # echo $count
}


$* > "$tempfile"
count_lines < "$tempfile"
echo $count