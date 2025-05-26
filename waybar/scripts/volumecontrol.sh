#!/usr/bin/env bash

set -e

# Directories
scrDir=$(dirname "$(realpath "$0")")
confDir=${confDir:-$XDG_CONFIG_HOME}
iconsDir="${iconsDir:-$XDG_DATA_HOME/icons}"
icodir="${iconsDir}/Wallbash-Icon/media"
step=${VOLUME_STEPS:-5}

# Notification toggle
isNotify=${VOLUME_NOTIFY:-true}
use_swayosd=false
if command -v swayosd-client >/dev/null && pgrep -x swayosd-server >/dev/null; then
    use_swayosd=true
fi

# Helper: send notification
notify_vol() {
    local vol=$1
    angle=$(( (vol + 2) / 5 * 5 ))
    [[ "$angle" -gt 100 ]] && angle=100
    ico="${icodir}/knob-${angle}.svg"
    bar=$(seq -s "." $((vol / 15)) | tr -d '[:digit:]')
    [[ "$isNotify" == true ]] && notify-send -a "Volume" -r 8 -t 800 -i "$ico" "${vol}${bar}" "${nsink}"
}

# Get PipeWire node ID
get_node_id() {
    local type=$1
    if [[ $type == "Sink" ]]; then
        wpctl status | grep -A5 "Sinks:" | grep "*" | awk '{print $3}' | cut -d. -f1
    else
        wpctl status | grep -A5 "Sources:" | grep "*" | awk '{print $3}' | cut -d. -f1
    fi
}


# Change volume
change_volume() {
    local action=$1
    local step_val=$2
    local type=$3  # Sink or Source
    local node_id
    node_id=$(get_node_id "$type")
    if [[ -z "$node_id" ]]; then echo "Could not find $type node"; exit 1; fi

    vol=$(wpctl get-volume "$node_id" | awk '{print int($2*100)}')

    # Do nothing if volume is at 100 or 0
    if [[ $vol -eq 100 && "$action" == "i" ]] || [[ $vol -eq 0 && "$action" == "d" ]]; then
        return 0  # Exit the function if no change is needed
    fi
 
    case $action in
        i) wpctl set-volume $node_id ${step_val}%+ ;;
        d) wpctl set-volume $node_id ${step_val}%- ;;
    esac

    vol=$(wpctl get-volume "$node_id" | awk '{print int($2*100)}')
    notify_vol "$vol"
}


# Toggle mute
toggle_mute() {
    local type=$1
    local node_id
    node_id=$(get_node_id "$type")
    wpctl set-mute "$node_id" toggle
    [[ "$isNotify" == true ]] && notify-send -a "Volume" -t 800 -r 8 "Toggled mute on $type"
}

# Select/toggle output (for now, just shows options — can be enhanced)
select_output() {
    wpctl status | awk '/Audio/ && /Sink/ {getline; print $0}' | cut -d '.' -f2-
}

# Parse options
while getopts "iop:stq" opt; do
    case $opt in
        i) device_type="Source" ;;
        o) device_type="Sink" ;;
        s) select_output; exit ;;
        t) echo "Toggle output not yet implemented"; exit ;;
        q) isNotify=false ;;
        *) echo "Invalid usage"; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# Run command
action=$1
step_val=${2:-$step}
case $action in
    i | d) change_volume "$action" "$step_val" "$device_type" ;;
    m) toggle_mute "$device_type" ;;
    *) echo "Invalid action"; exit 1 ;;
esac
