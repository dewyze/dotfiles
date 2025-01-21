return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require("fzf-lua")
    fzf.setup({ fzf_colors = true })

    vim.keymap.set("n", "<leader>ff", fzf.files, {})
    vim.keymap.set("n", "<C-p>", fzf.git_files, {})
    vim.keymap.set("n", "<leader>fg", fzf.live_grep, {})
    vim.keymap.set("n", "<leader>gw", fzf.grep_cword, {})
    vim.keymap.set("n", "<leader>fb", fzf.buffers, {})
    vim.keymap.set("n", "<leader>be", fzf.buffers, {})
  end
}
