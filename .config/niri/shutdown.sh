#!/bin/bash
killall waybar
swww img ~/Pictures/Wallpapers/wallpaper-black.png --transition-type simple --transition-duration 1
sleep 1.0
systemctl poweroff
