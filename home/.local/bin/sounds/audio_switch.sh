#!/bin/bash

HEADPHONES="alsa_output.pci-0000_00_1b.0.analog-stereo"
TV="alsa_output.pci-0000_01_00.1.hdmi-stereo"

# List of all available sound devices
# pactl list short sinks

# Headphones
# pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo

# TV Speakers
# pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo


audio-switch() {
    # Update these with your actual device IDs (use `pactl list short sinks`)
    
    if [ -z "$1" ]; then
        # Toggle between devices
        current=$(pactl get-default-sink)
        [ "$current" = "$HEADPHONES" ] && pactl set-default-sink "$TV" || pactl set-default-sink "$HEADPHONES"
    else
        # Direct selection
        [ "$1" = "h" ] && pactl set-default-sink "$HEADPHONES"
        [ "$1" = "t" ] && pactl set-default-sink "$TV"
    fi
}
