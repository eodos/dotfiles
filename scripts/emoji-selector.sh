#!/bin/bash

EMOJIS_PATH="$HOME/.config/rofi/emoji-list"

line=`cat $EMOJIS_PATH | rofi -dmenu -theme emoji -i -markup-rows -p "" -columns 6`
[[ -z $line ]] && exit
a="${line#*>}"
b="${a%<*}"
echo -n $b | xsel -ipb

xdotool key Ctrl+Shift+v
