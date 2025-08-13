#!/bin/bash

# My mirrored display setup. I have a desktop with a PC display + a TV attached.

# TODO: Maybe make this universal? It works for me, but will not work if I change my displays.

xrandr --output DVI-D-0 --primary --mode 1920x1080 \
       --output HDMI-1 --same-as DVI-D-0
