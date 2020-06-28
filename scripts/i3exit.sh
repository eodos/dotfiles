#!/usr/bin/env bash

case "$1" in
    lock)
        bash $HOME/scripts/lock.sh
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        bash $HOME/scripts/lock.sh & systemctl suspend
        ;;
    hibernate)
        systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 [lock|logout|suspend|hibernate|reboot|shutdown]"
        exit 2
esac

exit 0
