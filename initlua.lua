-- local remap = vim.api.nvim_set_keymap
-- local npairs = require("nvim-autopairs")
-- local endwise = require('nvim-autopairs.ts-rule').endwise
--
-- npairs.setup({
--     check_ts = true,
-- })
-- npairs.clear_rules()
-- _G.MUtils= {}
--
-- MUtils.completion_confirm=function()
--   print("define func")
--   if vim.fn.pumvisible() ~= 0  then
--     return npairs.esc("<cr>")
--   else
--     return npairs.autopairs_cr()
--   end
-- end
--
-- remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
-- npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
-- npairs.add_rules({
--     endwise('do$',         'end', 'ruby', 'do_block')
-- })

require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "elixir",
    "html",
    "javascript",
    "lua",
    "python",
    "ruby",
    "rust",
    "scss",
    "typescript",
    "yaml",
  },

  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- custom_captures = {
    --   -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
    --   ["@constant.builtin"] = "TSType",
    -- },
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
  -- indent = {
  --   enable = true,
  -- },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
  playground = {
    enable = true,
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    -- keybindings = {
    --   toggle_query_editor = 'o',
    --   toggle_hl_groups = 'i',
    --   toggle_injected_languages = 't',
    --   toggle_anonymous_nodes = 'a',
    --   toggle_language_display = 'I',
    --   focus_language = 'f',
    --   unfocus_language = 'F',
    --   update = 'R',
    --   goto_node = '<cr>',
    --   show_help = '?',
    -- },
  },
  -- autotag = {
  --   enable = true,
  -- }
}
