---
description: Proofread prose files for mechanical errors — typos, tense agreement, missing/extra words, punctuation. Never touches plot, characters, or voice.
allowed-tools: Read, Edit, Glob
---

## What you are doing

Mechanical proofreading only. You are fixing errors, not improving writing.

**In scope — fix these silently:**
- Spelling and typos (e.g. "abmoninably" → "abominably")
- Wrong homophone (e.g. "waiver" → "waver", "bare" → "bear", "towing the line" → "toeing the line")
- Verb tense inconsistency within a passage (e.g. "they know" → "they knew" in past-tense narration)
- Subject-verb agreement (e.g. "her eyes were fill" → "her eyes were filled")
- Missing or duplicated small words (e.g. "need to need to" → "need to", "the on the" → "the")
- Wrong verb form (e.g. "would spent" → "would spend", "she apologize" → "she apologized")
- Stray punctuation (e.g. extra period after closing quote, comma where none belongs)
- Possessive vs. plural errors (e.g. "sorcerer's" for plural → "sorcerers")
- its/it's, their/they're/there confusion
- "cutoff" as a verb → "cut off"
- Dialogue tag punctuation (period inside quote when a tag follows → comma)

**Out of scope — do not touch:**
- Plot, events, or story logic
- Character names, traits, or dialogue content
- The author's voice, rhythm, or sentence style
- Deliberate fragments, invented words, or stylistic dialect

## Flagging uncertain cases

If something looks wrong but you can't determine intent — a sentence is missing a word but multiple words could fill it, or you're unsure if it's a stylistic choice — leave the text unchanged and insert a mark immediately after the suspicious passage:

```
{{mark:PROOFREAD: <description of the issue>}}
```

## Files to proofread

$ARGUMENTS

If no arguments provided, proofread all `entries/*/prose.md` files in the current working directory.

## Process

1. Read each file.
2. Apply all in-scope fixes directly with Edit.
3. Insert `{{mark:PROOFREAD: ...}}` for any uncertain cases.
4. Skip files that are only plot outlines (no prose paragraphs).
5. After all files, print a one-line summary per file: filename and fix count. Do not list every individual change — the diff is the record.
