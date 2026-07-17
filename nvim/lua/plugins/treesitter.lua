return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "ruby", "embedded_template", "html", "css",
      "lua", "javascript", "typescript", "tsx",
      "json", "yaml", "toml",
      "markdown", "markdown_inline",
      "sql", "bash", "vim", "vimdoc",
    })

    -- On the main branch highlighting is not automatic; start it per buffer.
    -- pcall guards filetypes whose parser isn't installed.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- Structural folding available, but nothing folded on open.
    -- Ruby indent is left native on purpose — treesitter's ruby indent is weak.
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldlevel = 99
  end,
}
