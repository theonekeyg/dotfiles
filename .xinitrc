#!/usr/bin/env sh

[ -f ~/.xprofile ] && . ~/.xprofile

export $(dbus-launch --exit-with-session)
export DISPLAY=:1

exec i3
