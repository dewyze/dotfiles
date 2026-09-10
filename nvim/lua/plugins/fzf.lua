return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require("fzf-lua")
    fzf.setup({ fzf_colors = true })
    -- Handle vim.ui.select (code-action menus, etc.) in the same fzf UI
    fzf.register_ui_select()

    vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "find: files" })
    vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "find: git files" })
    vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "find: buffers" })
    vim.keymap.set("n", "<leader>ss", fzf.live_grep, { desc = "search: live grep" })
    -- \sw scopes to app code (specs/tests excluded); \sW is the force/global
    -- variant per the uppercase convention. Glob is prepended because the
    -- default rg_opts end in -e (the pattern follows).
    vim.keymap.set("n", "<leader>sw", function()
      fzf.grep_cword({
        rg_opts = "--glob '!**/{spec,test}/**' " .. require("fzf-lua.config").globals.grep.rg_opts,
      })
    end, { desc = "search: word under cursor (app)" })
    vim.keymap.set("n", "<leader>sW", fzf.grep_cword, { desc = "search: word everywhere" })
  end
}
