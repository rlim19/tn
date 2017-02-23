#!/usr/bin/env bash

declare -i i=0
declare logdir="${LOGDIR:-$HOME}/"

if [[ ! -d $logdir ]]; then
    mkdir -- "${logdir}" 2> /dev/null || { echo "cannot make dir: ${logdir}" 1>&2; exit 1; }
fi

declare logfile="${logdir}logfile.txt"
declare errorfile="${logdir}errorfile.txt"

if [[ "$1" == "-l" ]]; then
    echo "Logging is available at ${logfile} and error: ${errorfile}"
    exec -- > "$logfile" 2> "$errorfile"
fi

while true; do
    echo "still here $(( ++i ))"
    sleep 1
done
