#!/usr/bin/env sh

[ -f ~/.xprofile ] && . ~/.xprofile

if command -v "xrandr" > /dev/null; then
  xrandr --output eDP-1 --brightness 0.7
fi

exec i3
