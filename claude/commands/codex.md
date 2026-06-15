---
description: Update the codex knowledge base with new patterns, preferences, or corrections
allowed-tools: Read, Write, Edit, Grep, Glob
---

## Context

Codex index: !`cat ~/dev/codex/INDEX.md`

User's update request: $ARGUMENTS

## Your task

Update the codex knowledge base at `~/dev/codex/` based on the user's request.

### Steps

1. **Find the right file(s).** Match the user's request against the file descriptions in the index — not just filenames. The descriptions summarize each file's scope and topics. An update may affect multiple files. If it would help to grep the codex for a specific term, do so.

2. **Assess confidence.** How confident are you that this update belongs in existing file(s)?
   - **High confidence**: Read the file(s), make the edit(s), report what you changed.
   - **Low confidence** (no existing file covers this topic): Ask the user whether to create a new file or add to an existing one. Suggest the closest match. Don't ask if you're reasonably sure — just do it.

3. **Make the edit(s).**
   - **Adding a preference/opinion**: Add near the relevant section with brief reasoning.
   - **Correcting something**: Edit existing content. If removing a pattern, note what to use instead.
   - **Adding a new section**: Add a `##` heading with description, code example if helpful, and when to use/not use.
   - **Adding a new file**: Create it in the appropriate directory and add an entry to `INDEX.md`.

4. **Report what you did.** One sentence per file changed.

### Style rules

- Match the terse, prescriptive style of existing codex files
- Lead with the rule, follow with example if needed
- Don't add analysis framing
- Keep code examples short
