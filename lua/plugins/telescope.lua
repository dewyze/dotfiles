return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- SUGGEST: telescope-fzf-native is built but never loaded (no load_extension("fzf")) — unused?
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- Telescope earns its keep here: ui-select dresses vim.ui.select
			-- (code actions, etc.) in a dropdown. Pickers are fzf-lua's job.
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
