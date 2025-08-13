#!/bin/bash

# My extended display setup. I have a desktop with a PC display + a TV attached.

xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 \
       --output HDMI-1 --mode 1920x1080 --pos 1920x0
