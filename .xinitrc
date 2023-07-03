#!/usr/bin/env sh

[ -f ~/.xprofile ] && . ~/.xprofile

export $(dbus-launch)

exec i3
