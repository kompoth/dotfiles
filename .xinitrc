#!/bin/bash
xsetroot -cursor_name left_ptr
feh --bg-scale ~/dotfiles/wallpaper.png
xrdb -merge ~/.Xresources
setxkbmap -layout us,ru -model pc105 -option grp:win_space_toggle
sxhkd &
exec bspwm
