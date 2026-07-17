vim.lsp.config.ruby_lsp = {
  cmd = { "ruby-lsp" },
  root_markers = { "Gemfile" },
  filetypes = { "ruby" },
}
vim.lsp.enable({ "ruby_lsp" })

vim.lsp.config.sorbet = {
  cmd = { "srb", "tc", "--lsp" },
  root_markers = { "sorbet/" },
  filetypes = { "ruby" },
}

-- Only enable Sorbet if a sorbet/ directory exists in the current working directory
if vim.fn.isdirectory("sorbet") == 1 then
  vim.lsp.enable({ "sorbet" })
end
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Jumps live on g (grr/gri/grt/gO are core defaults); do's live on leader.
    -- See KEYBINDINGS.md.
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { buffer = ev.buf, desc = "explain: error" })
    vim.keymap.set("n", "<leader>ed", vim.lsp.buf.hover, { buffer = ev.buf, desc = "explain: docs" })
    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "refactor: rename symbol" })
    vim.keymap.set({ "n", "v" }, "<leader>ra", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "refactor: code action" })
  end
})
