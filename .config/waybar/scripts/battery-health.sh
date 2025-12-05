#!/bin/bash

# Get battery health percentage
# This calculates the ratio of current full capacity to original design capacity

BATTERY_PATH="/sys/class/power_supply/BATT"

if [ -f "$BATTERY_PATH/charge_full" ] && [ -f "$BATTERY_PATH/charge_full_design" ]; then
    CHARGE_FULL=$(cat "$BATTERY_PATH/charge_full")
    CHARGE_FULL_DESIGN=$(cat "$BATTERY_PATH/charge_full_design")

    # Calculate battery health percentage
    HEALTH=$(awk "BEGIN {printf \"%.1f\", ($CHARGE_FULL / $CHARGE_FULL_DESIGN) * 100}")

    # Set color to bright pink if health is 65% or lower
    if (( $(echo "$HEALTH <= 65" | bc -l) )); then
        COLOR="#ff1493"
    else
        COLOR="#F5F5DC"
    fi

    echo " <span color='$COLOR'>${HEALTH}%</span>"
elif [ -f "$BATTERY_PATH/energy_full" ] && [ -f "$BATTERY_PATH/energy_full_design" ]; then
    # Some batteries use energy instead of charge
    ENERGY_FULL=$(cat "$BATTERY_PATH/energy_full")
    ENERGY_FULL_DESIGN=$(cat "$BATTERY_PATH/energy_full_design")

    HEALTH=$(awk "BEGIN {printf \"%.1f\", ($ENERGY_FULL / $ENERGY_FULL_DESIGN) * 100}")

    # Set color to bright pink if health is 65% or lower
    if (( $(echo "$HEALTH <= 65" | bc -l) )); then
        COLOR="#ff1493"
    else
        COLOR="#F5F5DC"
    fi

    echo " <span color='$COLOR'>${HEALTH}%</span>"
else
    echo "N/A"
fi
