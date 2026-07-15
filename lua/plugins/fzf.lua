return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require("fzf-lua")
    fzf.setup({ fzf_colors = true })

    vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "find: files" })
    vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "find: git files" })
    vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "find: buffers" })
    vim.keymap.set("n", "<leader>ss", fzf.live_grep, { desc = "search: live grep" })
    vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "search: word under cursor" })
  end
}
