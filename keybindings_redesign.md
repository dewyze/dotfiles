# Keybindings redesign — conversation starter

Pick this up by reading this file, then look at current bindings in
`init.lua` and each app's config before proposing anything.

## The goal

Semantic keybindings with common, predictable prefixes shared across three
editors: normal nvim (this repo), `~/dev/vimoire`, and `~/dev/lore`. John
regularly forgets bindings he wrote himself — discoverability and a small
memorable grammar matter more than preserving any individual mapping.

Inspiration (not a spec — do NOT copy bindings verbatim):
https://github.com/Jitsusama/core.nix/blob/main/home-manager/neovim/KEYBINDINGS.md

Its useful ideas:
- Five input patterns, each with a distinct mental model: `<leader>x` = do
  something (namespaced by domain), `[`/`]` = step through ordered things,
  `g` = jump somewhere, `<C-x>` = system-level, bare keys = reserved for the
  truly constant.
- Domain letters: `b`uffers, `c`ode, `f`iles, `g`it, `s`earch, `t`ests.
- Double letter = the domain's picker (`<leader>ff`, `<leader>gg`).
- Uppercase = force/global variant of the lowercase command.
- The grammar is shared across all three editors; the vocabulary (which
  domains exist, what fills them) is per-app.

## Facts already established

- Leader is `\`. `mapleader` and `maplocalleader` are both set explicitly in
  `lua/config/lazy.lua`.
- John is torn about destroying 10+ years of muscle memory, but the
  three-editor situation plus forgetting his own custom bindings tilts him
  toward the redesign. Open question: greenfield renumbering vs careful
  migration.
- which-key.nvim is on the table for discoverability (domain menus on
  `<leader>x` pause).
- Plugin infra: vim.pack migration (nvim 0.12 native) was researched and
  recommended, John said hold for now. It affects how a shared keybinding
  module would load across the three apps — decide together which lands
  first.

## Related work already done (July 2026)

- Colorscheme family lives in `lua/palette/`: `nightshade` (dark default),
  `daybreak` (light), `wisp` (nightshade + washes behind data). One shared
  `apply.lua` maps any palette onto highlight groups. Switching is native
  `:colorscheme <Tab>`.
- Treesitter is on the nvim-treesitter `main` branch with textobjects and
  context; custom ruby captures in `after/queries/ruby/`.

## Future idea (explicitly not now)

A command palette (vim.ui.select-style) for common commands — theme
switching among them. If built, keybinding for it belongs in the semantic
scheme, so keep a slot in mind.
