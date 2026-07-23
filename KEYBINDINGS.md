# Keybindings — the semantic grammar

One grammar shared across three editors: this repo's nvim, `~/dev/vimoire`,
and `~/dev/lore`. The grammar (layers, conventions) is universal; the
vocabulary (which domains exist, what fills them) is per-app. Leader is `\`
everywhere, set explicitly.

Guardrail: this spec fits one page. A second page is the ontology-bloat alarm.

## Why this shape

- **Recall by derivation, not memorization.** John forgets bindings he
  wrote himself (~45% of the old set was forgotten or never used). The fix
  isn't better memory — it's a scheme you can *reconstruct*: five layers +
  five domain words is the entire burden; everything else is a guess that
  works or a menu that rescues (which-key on pause, palette by keyword).
- **The domain words are John's own.** Borrowed vocabulary doesn't stick;
  these words came out of "what kind of thing am I about to do,"
  independently per editor. Future domains must pass the same test.
- **Frequency beats taxonomy.** Test/export/LLM-analyze may be the same
  species philosophically; test keeps its own prime key because it runs
  hundreds of times a week. Purity never displaces a daily-loop key.
- **Keys are earned by use, not by features.** Real habits get bindings;
  aspirational features get dormant slots. (Lore is the exception by
  design — it's greenfield, specced with the grammar from day one.)
- **Hard cutover.** No breadcrumb stubs. The retraining method is: catch
  the old reflex, undo, retype the new way.

## The five layers

| Trigger | Mental model | In practice |
|---|---|---|
| `\` + domain + verb | do something | small set of domain words; which-key menu on pause |
| `g` | go somewhere known | definition, references, alternate, Rails files |
| `[` / `]` | step through ordered things | functions, diagnostics, (someday) hunks |
| `C-…` | system level | windows, tabs, panels, terminal — never content |
| bare keys | too frequent for a prefix | native vim + a few earned squatters |

Conventions:

- **Double letter = the domain's default act** (`\tt` nearest test, `\ee`
  explain error, `C-s C-s` main drawer). Uppercase = force/global variant.
- **Domains are acts, not tools.** Never name a key after a plugin
  (`\nt` = "nerdtree" survived a decade on a coin flip; don't repeat it).
- **Frequency beats taxonomy.** A pure category never displaces a
  daily-loop key.
- **Aliases are free** — under recall-by-derivation, either guess working
  costs nothing (`]m` = `]f`).
- **g = go's, `\` = do's.** When core or a plugin lumps a transform under a
  jump prefix, the canonical home is leader; the stock binding stays as a
  freebie.

## Code vocabulary (this repo)

Leader domains — the whole list:

| | | |
|---|---|---|
| `\t` **test** | `\tt` nearest · `\tf` file · `\ts` suite · `\tl` last · `\tc` context (ruby) | |
| `\f` **find** (nameable) | `\ff` files · `\fb` buffers | `C-p` = fast alias of `\ff` |
| `\s` **search** (by content) | `\ss` live grep · `\sw` word under cursor | |
| `\e` **explain** | `\ee` error float · `\ed` docs | `K` stays bare for hover |
| `\r` **refactor** (transforms) | `\rr` rename · `\ra` code action · `\rf` format · `\rw`/`\ru` wrap/unwrap ruby block | core `grn`/`gra` stay bound as freebies |
| `\p` **palette** | command palette (future) | singleton |

g layer (jumps): `gd` `gD` `grr` references `gri` implementation `grt`
type-def `gO` outline · `ga`/`gA` alternate (also covers code↔test) · Rails:
`grc` controller `grm` model `grv` view `grh` helper `grd` schema `grf`
feature · native `gc`/`gcc` comment operator, `gS`/`gJ` splitjoin.

Brackets: `]f`/`[f` (+`]m` aliases) functions · `]d`/`[d` diagnostics (core) ·
`]t`/`[t` tabs (shadows core's ctags-match stepping — a pre-LSP system
never used here) · `]b`/`[b` buffers, `]q`/`[q` quickfix (core freebies).

C layer: `C-w` windows (incl. `C-w m` maximize) · `C-T s/n/t/,/q` tabs ·
`C-s` **show namespace**: `C-s C-s` main drawer · `C-s C-f` reveal file ·
`C-s C-q` quickfix · `C-s C-t` terminal split · `C-/` comment · `C-c` (also
native `C-l`) clear
highlight (native) · `C-G` yank filename · insert `C-s` signature help
(core default, unshadowed — our `C-s` maps are normal-mode only) ·
t-mode `Esc Esc` exits terminal mode.

Bare keeps: visual `J`/`K` move lines · `<CR><CR>` split line · insert
`C-L` language-appropriate arrow (`=>`, `->` in elixir/elm — the
"language as property, not place" exemplar).

## Spine — shared across all three editors

`\p` palette · `C-s` drawer gesture (`C-s C-s` = this world's main panel;
each world binds its other drawers under `C-s C-<letter>`) · find/search
split (find = I can name it; search = hunt by content) · **capture** =
"store this idea elsewhere" · `Esc Esc` · double-letter rule. Sync is
opportunistic — driven by real friction, never by spec completeness.

Squatter rule: a plugin that binds `<C-s>` buffer-locally (inside its own
window) shadows the show prefix there — evict it to `<C-j>` (precedent:
lore's neo-tree).

## For the other editors

Binding: the five layers, the conventions above, the spine. Free: every
domain word beyond the spine — named in John's words for that world,
against real usage, not upfront. Per-editor worklists and accepted
deviations live in that editor's own repo (its `TODO.md` or equivalent),
never in this file.

## Dormant — reserved, not shipping yet

`\g` git + `\gh` github: the only deliberately unshipped domain. Shape is
decided — `\g` + noun + verb for local git (gitsigns/fugitive), `\gh…` for
the GitHub wing (octo), PR review lives inside it. The reference map (for
its mental model, never verbatim bindings):
https://github.com/Jitsusama/core.nix/blob/main/home-manager/neovim/KEYBINDINGS.md

`\a` **ai**: reserved for AI/assistant tooling when it returns — the letter
is free in all three editors. `\c`: free letter, unclaimed in code.

Tech someday-notes: wrap/unwrap on treesitter `@block` nodes instead of
regex; `treesj` if splitjoin misbehaves; vim.pack (nvim 0.12 native plugin
infra) was researched and held — it affects how a shared keybinding module
would load across the three apps, so revisit infra after the grammar lands.

## Transition ledger (delete after retraining)

`\rf→\tt` `\rb→\tf` `\ra→\ts` `\rl→\tl` `\rc→\tc` · `\gw→\sw` `\fg→\ss`
`\be→\fb` · `<Space>e→\ee` `<Space>ca→\ra` `<Space>n/p→]d/[d` ·
`\gf→\rf` `\bw→\rw` `\bu→\ru` · `gr→grr` · `C-S c/m/v/h/f/d→gr c/m/v/h/f/d`
(integration-test jump dropped; `ga` covers) · `\nt→C-s C-s` `\nf→C-s C-f`
(`\nr` dropped) · `\nh→C-l` · `\cc→C-/` · dead outright: `\sv` `\sI`
`\p`-as-paste `</` `C-X l/v`.
