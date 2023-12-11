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
# xsetroot -solid '#0AAEB3'
feh --no-fehbg --bg-center --image-bg '#121212' '/home/kmiziz/Media/wp.jpg' 
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

# start hotkey daemon and wm
sxhkd &
exec bspwm
#exec evilwm -term urxvt -bw 5 -fg '#98BC37' -fc '#0AAEB3' -bg '#918175'
