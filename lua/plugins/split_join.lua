return {
  "AndrewRadev/splitjoin.vim",
  config = function()
    vim.cmd("let g:splitjoin_trailing_comma = 1")
    vim.cmd("let g:splitjoin_ruby_hanging_args = 0")
    vim.cmd("let g:splitjoin_ruby_curly_braces = 0")
  end,
}
