#!/bin/bash
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources
setxkbmap -layout us,ru -model pc105 -option grp:win_space_toggle
sxhkd &
exec bspwm
