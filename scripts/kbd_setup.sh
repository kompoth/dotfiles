#!/bin/bash

# A list of target keyboard names recognised by xinput
KBD_NAMES="AT Translated Set 2 keyboard,Logitech USB Receiver"

IFS=',' ;for KBD in $KBD_NAMES; do
    setxkbmap -device $(xinput list --id-only $KBD) -layout us,ru -option grp:win_space_toggle
done
