#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai - Toggle Center of Screen
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/icon.png

# Documentation:
# @raycast.description Toggle center of screen
# @raycast.author hthuong09
# @raycast.authorURL https://raycast.com/hthuong09

yabai -m window --toggle float
# check if window is floating using regex instead of jq
if [[ $(yabai -m query --windows --window | grep -o '"is-floating":true') ]]; then
  yabai -m window --grid 4:4:1:1:2:2
fi
