#!/usr/bin/env -S LC_ALL=en_US.UTF-8 bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lore - Meeting Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📝
# @raycast.packageName Lore

# Documentation:
# @raycast.description Create/open a note for the current (or next) meeting in the active lore vault
# @raycast.author John DeWyze
# @raycast.authorURL https://github.com/dewyze

set -euo pipefail

ICALBUDDY=/opt/homebrew/bin/icalBuddy
PREFS="${LORE_PREFS:-$HOME/.lore/preferences.json}"
# The installed bundle ships its own launcher CLI — never the dev checkout.
LORE="$HOME/Applications/Lore.app/Contents/Resources/lore"

if [ ! -f "$PREFS" ]; then
  echo "no lore vault yet (:VaultAdd first)"
  exit 1
fi

VAULT=$(python3 -c '
import json, sys
prefs = json.load(open(sys.argv[1]))
print(prefs["vaults"][prefs["active_vault"]])
' "$PREFS")

# Current meeting first; fall back to today's list. -ea skips all-day
# events, -li 1 takes one event, -nc/-b strip calendar names and bullets.
grab() {
  "$ICALBUDDY" -nc -b "" -li 1 -ea -iep "title,attendees" -po "title,attendees" "$1" 2>/dev/null
}

OUT=$(grab eventsNow)
[ -z "$OUT" ] && OUT=$(grab eventsToday)
if [ -z "$OUT" ]; then
  echo "no meetings today"
  exit 1
fi

FILE=$(printf '%s\n' "$OUT" | python3 -c '
import json, os, re, sys
from datetime import date

lines = [l.strip() for l in sys.stdin.read().splitlines() if l.strip()]
title = lines[0]
attendees = ""
for line in lines[1:]:
    m = re.match(r"(?i)attendees:\s*(.*)", line)
    if m:
        attendees = m.group(1)

vault = sys.argv[1]
today = date.today()
slug = re.sub(r"_+", "_", re.sub(r"[^a-z0-9]+", "_", title.lower())).strip("_")
path = os.path.join(vault, "meetings", f"{today:%Y_%m_%d}_{slug}.md")

if not os.path.exists(path):
    template_path = os.path.join(vault, "templates", "meeting.md")
    if os.path.exists(template_path):
        body = open(template_path).read()
    else:
        body = (
            "---\ntype: Meeting\nmeeting: {{meeting}}\ndate: {{date}}\n"
            "attendees:{{attendees}}\nproject:\n---\n\n# {{title}}\n\n"
        )
    body = body.replace("{{date}}", f"{today:%Y-%m-%d}")
    # {{meeting}} is the recurring name: the event title, stable across
    # instances, so every "Team Sync" note carries one shared key while
    # {{title}} varies per note. Substituted pre-quoted, because a title
    # like "Sync: planning" would break a bare YAML scalar.
    body = body.replace("{{meeting}}", json.dumps(title))
    body = body.replace("{{title}}", title)
    # A block sequence, one quoted entry per line. A flow list breaks on any
    # entry holding a comma or a colon, and icalBuddy hands back whatever the
    # calendar has: display names for some people, bare emails for others.
    # {{attendees}} carries its own leading newline so the empty case can stay
    # inline — "attendees:" with nothing under it parses as null, not a list.
    people = [a.strip() for a in attendees.split(",") if a.strip()]
    entries = "\n".join("  - " + json.dumps(p) for p in people)
    body = body.replace("{{attendees}}", "\n" + entries if people else " []")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    open(path, "w").write(body)

print(path)
' "$VAULT")

"$LORE" "$FILE"
