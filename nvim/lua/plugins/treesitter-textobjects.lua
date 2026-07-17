return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "V",
        },
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true, -- push moves onto the jumplist
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")

    -- Select (visual + operator-pending). a = around, i = inner.
    -- f = function/method, c = class/module, a = argument. Change these to taste.
    local function sel(query)
      return function() select.select_textobject(query, "textobjects") end
    end
    vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"))
    vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"))
    vim.keymap.set({ "x", "o" }, "am", sel("@function.outer")) -- m = method, alias of f
    vim.keymap.set({ "x", "o" }, "im", sel("@function.inner"))
    vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"))
    vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"))
    vim.keymap.set({ "x", "o" }, "aa", sel("@parameter.outer"))
    vim.keymap.set({ "x", "o" }, "ia", sel("@parameter.inner"))

    -- Move by node. ]/[ = next/prev, lowercase = start, uppercase = end.
    vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)

    -- m aliases for method motion (override Vim's builtin ]m/[m with the treesitter version)
    vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end)
    vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end)
  end,
}
