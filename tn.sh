#!/usr/bin/env bash

# Simple note-taking script
# Author: Ricky Lim

declare -r date=$(date)
declare -r topic="$1"
declare notesdir=${NOTESDIR:-$HOME}

if [[ ! -d $notesdir ]]; then
    mkdir -- "${notesdir}" 2> /dev/null || { echo "cannot make dir: ${notesdir}" 1>&2; exit 1; }
fi

case $topic in
    shop*)
        declare -r filename="${notesdir}/shop_notes.txt";;
    study*)
        declare -r filename="${notesdir}/study_notes.txt";;
    *)
        declare -r filename="${notesdir}/notes.txt";;
esac

if [[ ! -f $filename ]]; then
    touch -- "${filename}" 2> /dev/null || { echo "cannot make a file: ${filename}" 1>&2; exit 1; }
fi

[[ -w $filename ]] || { echo "${filename} is not writeable" 1>&2; exit 1; }

# read -r -p "Write your note: " -- note;
echo "Write your note and exit with Enter + CTRL-D"
declare note=$(</dev/stdin)

if [[ $note ]]; then
    printf -- "%s\n%s\n" "$date" "$note" >> "$filename"
    # echo $date: "$note" >> "$filename"
    echo "Your note has been saved to '$filename'" 1>&2
else
    echo "Not input; nothing to save" 1>&2
    exit 1
fi

exit 0
