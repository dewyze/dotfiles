#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Audio - Speakers
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔊
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Set audio output device to MacBook Pro
# @raycast.author John DeWyze
# @raycast.authorURL https://github.com/dewyze

SwitchAudioSource -t output -s "Realtek USB2.0 Audio"
