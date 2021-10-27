#!/bin/bash
xsetroot -cursor_name left_ptr
setxkbmap -layout us,ru -model pc105 -option grp:win_space_toggle
xrdb -merge ~/.Xresources
sxhkd &
exec bspwm
