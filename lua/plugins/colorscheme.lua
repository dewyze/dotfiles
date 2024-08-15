return {
  -- dir = "~/dev/neodark.vim",
  -- config = function()
  --   vim.cmd.colorscheme("neodark")
  -- end
  --
	"mhartington/oceanic-next",
  config = function()
    vim.cmd.colorscheme("OceanicNext")
    vim.cmd([[
      if (has("termguicolors"))
        set termguicolors
      endif
    ]])
  end
}
