#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Paste Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Utils

# Documentation:
# @raycast.description Types out what is in the clipboard for websites that disable paste
# @raycast.author John DeWyze
# @raycast.authorURL https://github.com/dewyze

delay 0.5
tell application "System Events"
    keystroke (the clipboard)
end tell