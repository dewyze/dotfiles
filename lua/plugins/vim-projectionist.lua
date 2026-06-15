return {
	"tpope/vim-projectionist",
	config = function()
		vim.g.projectionist_heuristics = {
			-- Rails app using RSpec
			["app/&spec/"] = {
				["app/*.rb"] = { alternate = "spec/{}_spec.rb", type = "source" },
				["spec/*_spec.rb"] = { alternate = "app/{}.rb", type = "test" },
			},
			-- Rails app using minitest
			["app/&test/"] = {
				["app/*.rb"] = { alternate = "test/{}_test.rb", type = "source" },
				["test/*_test.rb"] = { alternate = "app/{}.rb", type = "test" },
			},
			-- Gem using RSpec
			["lib/&spec/&*.gemspec"] = {
				["lib/*.rb"] = { alternate = "spec/{}_spec.rb", type = "source" },
				["spec/*_spec.rb"] = { alternate = "lib/{}.rb", type = "test" },
			},
			-- Gem using minitest
			["lib/&test/&*.gemspec"] = {
				["lib/*.rb"] = { alternate = "test/{}_test.rb", type = "source" },
				["test/*_test.rb"] = { alternate = "lib/{}.rb", type = "test" },
			},
		}

		vim.keymap.set("n", "ga", ":A<CR>", { silent = true })
		vim.keymap.set("n", "gA", ":AV<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>c", ":Econtroller<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>m", ":Emodel<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>v", ":Eview<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>h", ":Ehelper<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>i", ":Eintegrationtest<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>s", ":A<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>f", ":Efeature<CR>", { silent = true })
		vim.keymap.set("n", "<C-S>d", ":Eschema<CR>", { silent = true })
	end,
}
