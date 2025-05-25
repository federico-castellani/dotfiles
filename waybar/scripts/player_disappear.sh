#!/bin/bash

playerctl --follow status | while read -r line; do
    # Get the current player status
    status=$(playerctl status 2>/dev/null)

    # Only proceed if the player is playing or paused
    if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
	echo "{\"text\": \" \", \"tooltip\": \"\"}"
    else
	echo "{\"text\": \"\", \"tooltip\": \"\"}"
    fi
done
