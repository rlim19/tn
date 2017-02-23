#!/usr/bin/env bash

usage () {
    cat <<EOF
Usage: count [-r] [-b n] [-s n] stop

-b gives the number to begin with (default to: 0)
-r reverse the count
-s step size (default to: 1)
Counting will stop at stop.
EOF
}

# First argument is an error message
# Second argument is the exit code
error () {
    echo "Error: $1"
    usage
    exit $2
} >& 2

isNum () {
    declare -r num_re='^[0-9]+$'
    declare -r octal_re='^0(.+)'
    num_error="ok"
    if [[ $1 =~ $num_re ]]; then
        if [[ $1 =~ $octal_re ]]; then
            num_error="$1 is not a number, do you mean ${BASH_REMATCH[1]} ?"
            return 1
        fi
    else
        num_error="$1 is not a number"
        return 1
    fi

    return 0;

}


declare reverse=""
declare -i begin=0
declare -i step=1

while getopts ":hrb:s:" opt; do
    case $opt in
        h)
            usage
            exit 0
            ;;
        r)
            reverse="true"
            ;;
        b)
            isNum "${OPTARG}" || error "${num_error}" 1
            begin="${OPTARG}"
            ;;
        s)
            isNum "${OPTARG}" || error "${num_error}" 1
            step="${OPTARG}"
            ;;
        :)
            echo "Option - ${OPTARG} is missing an argument" >&2
            exit 1
            ;;
        \?)
            echo "Unknown option: -${OPTARG}"
            exit 1
            ;;
    esac
done

shift $(( $OPTIND - 1 ))

while [[ $1 ]]; do

    [[ $1 =~ ^[0-9]+$ ]] || { echo "missing an argument 'stop'" >&2; exit 1; }
    declare -i end=$1
    shift

    if [[ ! $reverse ]]; then
        for (( i=begin; i <= end; i+=step )); do
            echo $i
        done
    else
        for (( i=end; i >= start; i-=step )); do
            echo $i
        done
    fi
done

exit 0

