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
vim.lsp.enable({ "sorbet" })
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    --   vim.lsp.diagnostic.on_publish_diagnostics, {
    --     -- delay update diagnostics
    --     update_in_insert = false,
    --   }
    -- )
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>n', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>p', vim.diagnostic.goto_prev, opts)
    -- vim.keymap.set('n', '<space>f', function()
      --   vim.lsp.buf.format { async = true }
      -- end, opts)
  end
})
