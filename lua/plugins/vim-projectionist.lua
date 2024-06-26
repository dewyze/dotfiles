return {
  "tpope/vim-projectionist",
  config = function()
    vim.keymap.set("n", "<C-S>c", ":Econtroller<CR>", { silent = true })
    vim.keymap.set("n", "<C-S>m", ":Emodel<CR>", { silent = true })
    vim.keymap.set("n", "<C-S>v", ":Eview<CR>", { silent = true })
    vim.keymap.set("n", "<C-S>h", ":Ehelper<CR>", { silent = true })
    vim.keymap.set("n", "<C-S>i", ":Eintegrationtest<CR>", { silent = true })
    vim.keymap.set("n", "<C-S>s", ":A<CR>", { silent = true })
    vim.keymap.set("n", "<C-S>f", ":Efeature<CR>", { silent = true })
    vim.keymap.set("n", "<C-S>d", ":Eschema<CR>", { silent = true })
  end,
}
