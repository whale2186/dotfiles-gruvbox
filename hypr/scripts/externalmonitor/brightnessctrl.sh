
#!/bin/bash

# Read the current brightness value using awk to extract the number
current_brightness=$(ddcutil --bus=3 getvcp 10 | awk -F'[,=]' '/Brightness/{print $2}' | tr -d '[:space:]')

increase_int=10 #set the custom brightness variables
decrease_int=10
# Check if the current brightness was retrieved successfully
if [ -z "$current_brightness" ]; then
    exit 1
fi

# Calculate the new brightness value by adding 5
if [[ $1 == "up" ]]; then
  new_brightness=$((current_brightness + increase_int))
elif [[ $1 == "down" ]]; then
  new_brightness=$((current_brightness - decrease_int))
elif [[ $1 == "custom" ]]; then
  new_brightness=$2
fi

# Ensure the new brightness doesn't exceed 100 (assuming 100 is the max value)
if [ $new_brightness -gt 100 ]; then
    new_brightness=100
fi

# Set the new brightness value
ddcutil --bus=3 setvcp 10 $new_brightness

