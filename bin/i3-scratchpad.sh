#!/usr/bin/env bash

tmpfile=$(mktemp)
trap 'rm -rf "${tmpfile}"' EXIT

xterm -class "__i3_scratchpad" -e $SHELL -lc \
  "nvim -c startinsert -c 'setlocal filetype=markdown' ${tmpfile}" \
  && xclip -selection clipboard < $tmpfile
