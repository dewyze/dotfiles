#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pull Out Window
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon H
#
# Documentation:
# @raycast.description Pulls out the current window to right third
# @raycast.author John DeWyze
# @raycast.authorURL https://github.com/dew

tell application "System Events" to key code 13 using {shift down}
delay 0.25
tell application "System Events" to key code 37 using {control down, option down, command down}
