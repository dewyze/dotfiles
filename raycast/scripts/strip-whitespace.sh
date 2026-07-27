#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Strip Whitespace
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Remove whitespace from the end of the clipboard
# @raycast.author John DeWyze
# @raycast.authorURL https://github.com/dewyze

pbpaste | sed -E 's/[[:space:]]+($|│.*)//g' | pbcopy
