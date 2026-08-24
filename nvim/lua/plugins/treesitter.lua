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

    -- Starting treesitter turns regex syntax off, and vim-ruby's
    -- GetRubyIndent() reads synID() to tell code from strings and comments --
    -- without it every line indents to 0 and '=' looks inert. Ruby is the
    -- outlier: lua and javascript consult syntax only for strings and comments
    -- and indent the same either way, so they keep the single parse.
    --
    -- This can't live in after/ftplugin: those run from the filetypeplugin
    -- autocmd, first in the FileType chain, so treesitter.start() above would
    -- undo it. Registering after that callback is what makes it stick.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "ruby", "eruby" },
      callback = function(ev)
        vim.bo[ev.buf].syntax = "ON"
      end,
    })

    -- Structural folding available, but nothing folded on open.
    -- Ruby indent is left native on purpose — treesitter's ruby indent is weak.
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.o.foldlevel = 99
  end,
}
