return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>")
		vim.keymap.set("n", "<leader>nr", ":Neotree<CR>")
		vim.keymap.set("n", "<leader>nf", ":Neotree reveal<CR>")
	end,
}
