#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Audio - Scarlett Focusrite
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎧
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Set audio output device to Scarlett Focusrite
# @raycast.author John DeWyze
# @raycast.authorURL https://github.com/dewyze

SwitchAudioSource -t output -s "Scarlett Solo USB"
