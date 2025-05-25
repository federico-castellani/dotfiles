#!/bin/sh

URL="http://federicocastellani.ddns.net:1337/api/v1/entries.json?token=homeassist-7afc50c1d34f2536"

# Fetch JSON data
json=$(wget -qO- "$URL")

# Extract the two most recent entries
latest_entry=$(echo "$json" | jq 'sort_by(.date) | reverse | .[0]')
previous_entry=$(echo "$json" | jq 'sort_by(.date) | reverse | .[1]')

# Parse values
sgv=$(echo "$latest_entry" | jq -r '.sgv')
direction=$(echo "$latest_entry" | jq -r '.direction')
utc_time=$(echo "$latest_entry" | jq -r '.dateString')

prev_sgv=$(echo "$previous_entry" | jq -r '.sgv')

# Convert UTC to local time
local_time=$(date -d "$utc_time" +"%H:%M:%S")

# Arrow direction symbols
get_arrow() {
    case "$1" in
        DoubleUp) echo "↑↑" ;;
        SingleUp) echo "↑" ;;
        FortyFiveUp) echo "↗" ;;
        Flat) echo "→" ;;
        FortyFiveDown) echo "↘" ;;
        SingleDown) echo "↓" ;;
        DoubleDown) echo "↓↓" ;;
        *) echo "?" ;;
    esac
}
arrow=$(get_arrow "$direction")

# Calculate delta
delta="?"
if [ -n "$sgv" ] && [ -n "$prev_sgv" ] && [ "$sgv" -eq "$sgv" ] 2>/dev/null && [ "$prev_sgv" -eq "$prev_sgv" ] 2>/dev/null; then
    delta=$((sgv - prev_sgv))
    [ "$delta" -gt 0 ] && delta="+$delta"
fi

# Output JSON for Waybar
echo "{\"text\": \"$sgv $arrow\", \"tooltip\": \"Updated at $local_time\\nChange: $delta mg/dL\", \"class\": \"glucose\"}"

