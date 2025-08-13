#!/bin/bash
# Filename: save_display.sh
# Save current display settings to ~/.extended_layout

# xrandr --verbose | grep -A5 " connected" > ~/.extended_layout
# echo "Display settings saved to ~/.extended_layout"


# Save display settings to ~/.config/display_layout

CONFIG_FILE="${HOME}/.config/display_layout"

# Create config directory if missing
mkdir -p "$(dirname "$CONFIG_FILE")"

# Capture complete display info with modes and positions
xrandr --verbose | awk '
    / connected/ { 
        display = $1; 
        print "Display: " display; 
        getline; 
        while ($0 !~ /^[[:space:]]*$/) {
            print; 
            if(getline <= 0) break;
        }
        print "---"
    }
' > "$CONFIG_FILE"

# Verify capture
if grep -q " connected" "$CONFIG_FILE"; then
    echo "Display settings saved to $CONFIG_FILE"
else
    echo "Error: No displays detected!" >&2
    exit 1
fi
