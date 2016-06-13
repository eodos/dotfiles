#!/bin/bash

IN="LVDS1"

EXT="VGA1"

if (xrandr | grep "HDMI1 connected"); then
	EXT="HDMI1"
fi

if (xrandr | grep "$EXT disconnected"); then
	xrandr --output $IN --auto --output HDMI1 --off --output VGA1 --off 
else
	xrandr --output $IN --auto --primary --output $EXT --auto --left-of $IN
fi

feh --bg-fill Dropbox/simple.png
