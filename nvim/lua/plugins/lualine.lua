return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				-- Custom theme in lua/lualine/themes/, generated from the
				-- nightshade palette (iceberg-dark darkness, nightshade hues).
				theme = "nightshade",
				-- showtabline=1 semantics: bar appears only with 2+ tabs
				always_show_tabline = false,
			},
			-- Tabline drawn by lualine so tabs share the statusline's theme and
			-- powerline chevrons. Taboo still owns naming (C-T n/,/s); its names
			-- live in the taboo_tab_name tabvar, read back here. Taboo's own
			-- tabline rendering is disabled in taboo.lua.
			tabline = {
				lualine_a = {
					{
						"tabs",
						mode = 2, -- number + name
						max_length = function()
							return vim.o.columns
						end,
						-- Location, not mode: orange appears in no mode section, so
						-- the active tab reads as a place marker, not a mode echo.
						tabs_color = {
							active = { fg = "#1c1c1c", bg = require("palette.nightshade").orange, gui = "bold" },
							inactive = { fg = require("palette.nightshade").comment, bg = "#262626" },
						},
						fmt = function(name, tab)
							local taboo = vim.fn.gettabvar(tab.tabnr, "taboo_tab_name")
							return taboo ~= "" and taboo or name
						end,
					},
				},
			},
		})
	end,
}
