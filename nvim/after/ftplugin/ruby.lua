vim.api.nvim_buf_create_user_command(0, "RspecState", function()
	require("rspec_state").show()
end, { desc = "Show effective let/subject state for the example under the cursor" })
