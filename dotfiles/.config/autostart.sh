#!/usr/bin/bash
# Nastavíme rozlišení obrazovky
xrandr -s 1920x1080
/usr/libexec/polkit-gnome-authentication-agent-1 &
# Start applications when qtile starts
nm-applet &