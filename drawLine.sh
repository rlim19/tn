#!/usr/bin/env bash

# Outputs a line of characters
# 1st arg is length of line
# 2nd arg is character to draw, default to '='

if [[ ! $1 ]]; then
    echo "Required a length argument" >&2
    exit 1
fi

if [[ $1 =~ ^[0-9]+$ ]]; then
    length=$1
else
    echo "Length has to be a number" >&2
    exit 1
fi

char="="
if [[ $2 ]]; then
    char="$2"
fi

line=
for (( i=0; i<length; ++i )); do
    line="${line}${char}"
done

printf "%s\n" "${line}"
exit 0




