#!/bin/bash

count=$(niri msg -j windows | jq '. | length')

if [ "$count" -eq 0 ]; then
    # Use border color (#303030) when count is zero
    echo " <span color='#303030'>$count</span>"
else
    # Use clock color (#F5F5DC) when count is 1 or more
    echo " <span color='#F5F5DC'>$count</span>"
fi
