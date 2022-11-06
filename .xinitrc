#!/bin/bash

# disable bell
xset b off

# merge Xresources
xrdb -merge ~/.Xresources

# setup keyboard and displays
setxkbmap -layout us,ru -model pc105 -option grp:win_space_toggle -option terminate:ctrl_alt_bksp
xrandr --output eDP1 --primary --mode 1920x1080 --rotate normal 
xrandr --output DP1 --mode 1920x1080 --rotate normal --right-of eDP1

# start batloop
PIDS=$(pgrep umess; pgrep ubatloop)
[ ! -z "$PIDS" ] && kill $PIDS
~/dotfiles/scripts/ubatloop &

# start some nice programs
sxhkd &
exec evilwm -term urxvt -bw 5
