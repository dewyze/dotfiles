return {
	"github/copilot.vim",
	config = function()
    vim.cmd("let g:copilot_no_tab_map = v:true")
    vim.keymap.set("i", "<C-V>&", "<C-V>", { buffer = true })
    vim.keymap.set("i", "<C-V>%", "<C-V>", { buffer = true })
    vim.keymap.set("i", "<C-V>", "copilot#Accept('<CR>')", { nowait = true, silent = true, script = true, expr = true, replace_keycodes = false })
  end,
}
