#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai - Toggle Gap/Padding
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/icon.png

# Documentation:
# @raycast.description Toggle gap and padding
# @raycast.author hthuong09
# @raycast.authorURL https://raycast.com/hthuong09

yabai -m space --toggle padding; yabai -m space --toggle gap
