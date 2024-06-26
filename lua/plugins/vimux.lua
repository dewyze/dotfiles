return {
	"benmills/vimux",
	config = function()
		vim.cmd("let g:VimuxUseNearestPane = 1")
		vim.cmd("let g:VimuxOrientation = 'h'")
		vim.cmd("let g:VimuxHeight = '40'")
	end,
}
