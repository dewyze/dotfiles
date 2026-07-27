#!/usr/bin/env -S LC_ALL=en_US.UTF-8 bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lore - Inbox
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "thought" }

# Optional parameters:
# @raycast.icon 📥
# @raycast.packageName Lore

# Documentation:
# @raycast.description Append a thought to the active lore vault's inbox
# @raycast.author John DeWyze
# @raycast.authorURL https://github.com/dewyze

set -euo pipefail

PREFS="${LORE_PREFS:-$HOME/.lore/preferences.json}"

if [ ! -f "$PREFS" ]; then
  echo "no lore vault yet (:VaultAdd first)"
  exit 1
fi

VAULT=$(python3 -c '
import json, sys
prefs = json.load(open(sys.argv[1]))
print(prefs["vaults"][prefs["active_vault"]])
' "$PREFS")

printf '%s\n' "$1" >> "$VAULT/inbox.md"
echo "inboxed"
