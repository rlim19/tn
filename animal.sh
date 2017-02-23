#!/usr/bin/env bash

case "$1" in
    cat)
        echo "Meoow";;
    dog)
        echo "GukGuk";;
    *)
        echo "Unknown animals";;
esac
exit 0