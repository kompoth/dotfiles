#!/bin/bash

# disable bell
xset b off

# setup keyboards
~/.local/bin/kbd_setup.sh

# start batloop
PIDS=$(pgrep umess; pgrep ubatloop)
[ ! -z "$PIDS" ] && kill $PIDS
~/.local/bin/ubatloop &

# root color, Xresources, initial cursor fix
feh --no-fehbg --bg-center --image-bg '#121212' '/home/kmiziz/Pictures/wp.jpg' --xinerama-index 0 
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

# start hotkey daemon and wm
sxhkd &
exec bspwm
#exec evilwm -term urxvt -snap 5 -fg '#a89984' -fc '#cc241d' -bg '#928374'
