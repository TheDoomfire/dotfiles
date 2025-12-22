#!/bin/bash

# Get the directory where this script is located
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DISPLAY_DIR="$THIS_DIR/layouts"

if xrandr --current | grep "HDMI-1 connected" | grep -q "+1920+0"; then
   bash "$SCRIPT_DISPLAY_DIR/mirror.sh"
else
   bash "$SCRIPT_DISPLAY_DIR/extended.sh"
fi
