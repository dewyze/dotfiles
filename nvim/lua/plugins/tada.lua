return {
	"dewyze/tada.nvim",
	config = function()
		-- Plan namespace (C-q) — see KEYBINDINGS.md
		require("tada").setup({
			keys = {
				pane = "<C-q><C-q>",
				pick = "<C-q><C-f>",

				-- inside a plan only
				archived = "<C-q>a",
				archive_selection = "<C-q>A",
				archive_plan = "<C-q>A",
				levels = "<C-q>",
				open_topic = { "<C-q>o", "<C-q>O" },
				close_topic = "<C-q>c",
			},
		})
	end,
}
