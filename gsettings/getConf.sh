#!/usr/bin/bash

if [ -f gsettings ]; then
  rm gsettings
fi

for schema in $(gsettings list-schemas | sort); do
  for key in $(gsettings list-keys $schema); do
    echo $schema $key $(gsettings get $schema $key) >> gsettings
  done
done
