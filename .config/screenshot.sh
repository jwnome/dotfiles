#!/bin/bash

# Create screenshots directory if it doesn't exist
mkdir -p ~/Pictures/Screenshots

# Generate filename with timestamp
FILENAME=~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png

# Take screenshot of selected area
grim -g "$(slurp)" - | swappy -f - -o "$FILENAME"
