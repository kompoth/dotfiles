#!/bin/bash

# disable bell
xset b off

# setup keyboard and displays
setxkbmap -layout us,ru -model pc105 -option grp:win_space_toggle -option terminate:ctrl_alt_bksp

# start batloop
PIDS=$(pgrep umess; pgrep ubatloop)
[ ! -z "$PIDS" ] && kill $PIDS
~/dotfiles/scripts/ubatloop &

# root color, Xresources, initial cursor fix
xsetroot -solid '#121212'
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

# start hotkey daemon and wm
sxhkd &
exec bspwm
#exec evilwm -term urxvt -bw 5 -fg '#98BC37' -fc '#0AAEB3' -bg '#918175'
