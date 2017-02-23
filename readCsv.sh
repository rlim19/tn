#!/usr/bin/env bash

while IFS="," read -r a b || [[ $a ]]; do
    echo $a
done

