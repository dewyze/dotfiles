return {
	"benmills/vimux",
	config = function()
		-- Reuse a pane, but only one titled VimuxRunnerName. Bare "nearest"
		-- takes whatever sits closest, Claude panes included; the name narrows
		-- that search to matching pane titles and is also stamped on any pane
		-- vimux opens itself. So a pane titled by hand (C-a y) gets adopted,
		-- and an auto-opened one gets reused on the next run. UseNearest must
		-- stay on -- off skips the filter path and always creates a new pane.
		-- (Was VimuxUseNearestPane, a name this plugin no longer reads.)
		vim.g.VimuxUseNearest = true
		vim.g.VimuxRunnerName = 'test'
		vim.g.VimuxOrientation = 'h'
		vim.g.VimuxHeight = '40'
	end,
}
