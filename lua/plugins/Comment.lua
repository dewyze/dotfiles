return {
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<leader>cc",
					block = "<leader>bc",
				},
				opleader = {
					---Line-comment keymap
					line = "<Leader>cc",
				},
			})
		end,
	},
}
