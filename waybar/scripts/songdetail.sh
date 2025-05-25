#!/bin/bash

# Use playerctl to follow the player's metadata changes
playerctl --follow metadata | while read -r line; do
    # Get the current song info using playerctl
    song=$(playerctl metadata title)
    artist=$(playerctl metadata artist)
    album=$(playerctl metadata album)
    player=$(playerctl -l | head -n 1)    

    if [[ -z "$song" ]]; then
        echo "{\"text\": \"\", \"tooltip\": \"\"}"
        continue
    fi

    icon="󰎇"
    # Choose the icon based on the player
    case $player in
        *spotify*)
            icon=""  # Spotify icon
            ;;
        *vlc*)
            icon="󰕼"  # VLC icon
            ;;
        *chrome*)
            icon=""  # Chrome icon
            ;;
        *chromium*)
            icon=""  # Chrome icon
            ;;
        *firefox*)
            icon="󰈹"  # Firefox icon
            ;;
        *)
            icon="󰎇"  # Default music icon for unknown players
            ;;
    esac

    song_length=25
    artist_length=20

    song=$(echo "$song" | awk -v len="$song_length" '{print substr($0, 1, len)}')
    artist=$(echo "$artist" | awk -v len="$artist_length" '{print substr($0, 1, len)}')

    # Remove trailing space if any
    song="${song%" "}"
    artist="${artist%" "}"

    # Output the song details in JSON format for Waybar
    echo "{\"text\": \"$song $icon $artist\", \"tooltip\": \"$album\"}"
done
