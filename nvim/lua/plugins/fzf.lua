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
    -- Lowercase searches skip specs/tests; uppercase is the force/global
    -- variant per the uppercase convention. Glob is prepended because the
    -- default rg_opts end in -e (the pattern follows).
    local function without_specs(opts)
      return vim.tbl_extend("force", {
        rg_opts = "--glob '!**/{spec,test}/**' " .. require("fzf-lua.config").globals.grep.rg_opts,
      }, opts or {})
    end
    vim.keymap.set("n", "<leader>ss", function()
      fzf.live_grep(without_specs())
    end, { desc = "search: live grep (no specs)" })
    vim.keymap.set("n", "<leader>sS", fzf.live_grep, { desc = "search: live grep everywhere" })
    vim.keymap.set("n", "<leader>sw", function()
      fzf.grep_cword(without_specs())
    end, { desc = "search: word under cursor (no specs)" })
    vim.keymap.set("n", "<leader>sW", fzf.grep_cword, { desc = "search: word everywhere" })
  end
}
