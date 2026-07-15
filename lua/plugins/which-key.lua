return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({})

		-- The domain words — see KEYBINDINGS.md
		wk.add({
			{ "<leader>t", group = "test" },
			{ "<leader>f", group = "find" },
			{ "<leader>s", group = "search" },
			{ "<leader>e", group = "explain" },
			{ "<leader>r", group = "refactor" },
			{ "gr", group = "go: lsp + rails" },
			{ "<C-s>", group = "show" },
		})
	end,
}
