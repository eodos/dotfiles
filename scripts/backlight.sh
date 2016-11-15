#!/usr/bin/env bash
#xbacklight "$@"
#pkill -RTMIN+2 i3blocks

light -s acpi_video0 "$@"
pkill -RTMIN+2 i3blocks
