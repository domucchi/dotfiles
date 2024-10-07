#!/usr/bin/env bash
# Wofi window selector for Hyprland using jq

# Get the state of all windows
state="$(hyprctl -j clients)"
active_window="$(hyprctl -j activewindow)"

# Get the address of the currently active window
current_addr="$(echo "$active_window" | jq -r '.address')"

# List windows and their associated workspaces
window_list="$(echo "$state" |
  jq -r '.[] | select(.monitor != -1) | "\(.address)   \(.workspace.name)   \(.title) (in: \(.class))"' |
    sed "s|$current_addr|focused ->|")"

# Check if there are any windows
if [[ -z "$window_list" ]]; then
    echo "No active windows found."
    exit 1
fi

echo "$window_list"

# Use Wofi to select a window
selected_window=$(echo "$window_list" | wofi --show dmenu)

# Extract the address and workspace of the selected window
addr="$(echo "$selected_window" | awk '{print $1}')"
ws="$(echo "$selected_window" | awk '{print $2}')"

# Check if the selected window is already focused
if [[ "$addr" =~ focused* ]]; then
    echo 'Already focused, exiting'
    exit 0
fi

# Check for fullscreen windows in the same workspace
fullscreen_on_same_ws="$(echo "$state" | jq -r ".[] | select(.fullscreen == true) | select(.workspace.name == \"$ws\") | .address")"

if [[ -n "$addr" ]]; then
    # Focus the selected window
    if [[ -z "$fullscreen_on_same_ws" ]]; then
        hyprctl dispatch focuswindow address:"${addr}"
    else
        # If another window is fullscreen on the same workspace, ensure the selected window is focused correctly
        notify-send 'Complex switch' "$selected_window"
        hyprctl --batch "dispatch focuswindow address:${fullscreen_on_same_ws}; dispatch fullscreen 1; dispatch focuswindow address:${addr}; dispatch fullscreen 1"
    fi
fi
