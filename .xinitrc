#!/bin/bash
xset b off
xsetroot -cursor_name left_ptr -solid "#A0A1A7"
xrdb -merge ~/.Xresources
setxkbmap -layout us,ru -model pc105 -option grp:win_space_toggle -option terminate:ctrl_alt_bksp
xrandr --output eDP1 --primary --mode 1920x1080 --rotate normal 
xrandr --output HDMI1 --mode 1920x1080 --rotate normal --right-of eDP1

PIDS=$(pgrep umess; pgrep ubatloop)
[ ! -z "$PIDS" ] && kill $PIDS
~/dotfiles/scripts/ubatloop &

sxhkd &
exec evilwm -term urxvt -fg '#000000' -bg '#d0d0d0' -bw 5
