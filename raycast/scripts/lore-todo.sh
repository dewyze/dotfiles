#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lore - Todo
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "todo" }

# Optional parameters:
# @raycast.icon ✅
# @raycast.packageName Lore

# Documentation:
# @raycast.description Append a todo to the active lore vault's todo.md
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

printf -- '- [ ] %s\n' "$1" >> "$VAULT/todo.md"
echo "added to todo"
