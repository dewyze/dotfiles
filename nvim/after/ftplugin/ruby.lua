vim.api.nvim_buf_create_user_command(0, "RspecState", function()
	require("rspec_state").show()
end, { desc = "Show effective let/subject state for the example under the cursor" })

vim.api.nvim_buf_create_user_command(0, "LetToVar", function(opts)
	require("rspec_let").to_assignment(0, opts.line1, opts.line2)
end, { range = true, desc = "Rewrite one-line lets in range as variable assignments" })

vim.keymap.set({ "n", "x" }, "<leader>rtlv", ":LetToVar<CR>", {
	buffer = true,
	silent = true,
	desc = "refactor test: let to var",
})

vim.keymap.set("n", "<leader>es", function()
	require("rspec_state").show()
end, { buffer = true, desc = "explain: state" })
