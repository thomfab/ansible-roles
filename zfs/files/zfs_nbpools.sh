#! /bin/bash

NBPOOLS=$(/usr/sbin/zpool list -H | wc -l)

if [[ $NBPOOLS -eq 0 ]]; then
    echo "No pool found"
    exit 1
else
    /usr/sbin/zpool list
    exit 0
fi