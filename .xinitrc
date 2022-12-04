#!/bin/bash

# disable bell
xset b off

# setup keyboard and displays
setxkbmap -layout us,ru -model pc105 -option grp:win_space_toggle -option terminate:ctrl_alt_bksp
xrandr --output eDP1 --primary --mode 1920x1080 --rotate normal 
xrandr --output DP1 --mode 1920x1080 --rotate normal --right-of eDP1
xrandr --output HDMI1 --mode 1280x1024 --rotate normal --right-of DP1

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
exec evilwm -term urxvt -bw 5 -fg '#98BC37' -fc '#0AAEB3' -bg '#918175'
