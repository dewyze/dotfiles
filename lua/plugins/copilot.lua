return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true
		-- vim.keymap.set("i", "<C-V>&", "<C-V>", { buffer = true })
		-- vim.keymap.set("i", "<C-V>%", "<C-V>", { buffer = true })
		vim.keymap.set(
			"i",
			"<C-V>",
			'copilot#Accept("\\<CR>")',
			{ expr = true, replace_keycodes = false }
		)
	end,
}
