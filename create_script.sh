#!/usr/bin/env bash

# Create bash script, set permission, and etc
# Author: Ricky Lim

if [[ ! $1 ]]; then
    echo "Missing argument"
    exit 1
fi

declare open_editor=""
if [[ $# -eq 1 ]]; then
    open_editor="true"
fi

declare -r bindir="${HOME}/bin"

if [[ ! -d ${bindir} ]]; then
    if mkdir "$bindir"; then
        echo "Created $bindir" >&2
    else
        echo "Could not create $bindir" >&2
        exit 1
    fi
fi

while [[ $1 ]]; do
    scriptname="$1"
    filename="${bindir}/${scriptname}"

    if [[ -e $filename ]]; then
        echo "File ${filename} already exists"
        shift
        continue
    fi

    if type "${scriptname}" > /dev/null 2>1; then
        echo "There is already a command with name ${scriptname}" >&2
        shift
        continue
    fi

    echo "#!/usr/bin/env bash" > "$filename"
    chmod u+x "$filename"
    shift
done

exit 0

if [[ $EDITOR ]]; then
    $EDITOR "$filename"
else
    echo "Script created but editor is not started because \$EDITOR is not set."
fi

exit 0
