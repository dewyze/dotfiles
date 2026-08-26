return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			-- Popup delay; stock is 200ms, which surfaces the menu mid-thought.
			-- Keep the special popups (registers, marks) instant.
			delay = function(ctx)
				return ctx.plugin and 0 or 600
			end,
		})

		-- The domain words — see KEYBINDINGS.md
		wk.add({
			{ "<leader>t", group = "test" },
			{ "<leader>f", group = "find" },
			{ "<leader>s", group = "search" },
			{ "<leader>e", group = "explain" },
			{ "<leader>r", group = "refactor" },
			{ "<leader>y", group = "yank" },
			{ "gr", group = "go: lsp + rails" },
			{ "<C-s>", group = "show" },
		})
	end,
}
