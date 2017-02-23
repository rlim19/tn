#!/usr/bin/env bash

usage () {
    cat <<EOF
Usage $0 <old_ext> <new_ext>
e.g: $0 .txt .jpg
EOF
}

[[ $# -ne 2 ]] && { echo "Required 2 arguments" >&2; usage; exit 1; }
for f in *"$1"; do
    mv -- "$f" "${f/%$1/$2}"
done
