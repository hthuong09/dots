#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yabai - Enable Stack Mode
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/icon.png

# Documentation:
# @raycast.description Enable tiling mode for the current workspace
# @raycast.author hthuong09
# @raycast.authorURL https://raycast.com/hthuong09

yabai -m space --layout stack
