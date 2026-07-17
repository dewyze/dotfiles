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

		vim.keymap.set("n", "ga", ":A<CR>", { silent = true, desc = "go: alternate file" })
		vim.keymap.set("n", "gA", ":AV<CR>", { silent = true, desc = "go: alternate (vsplit)" })
		-- go rails: cohabits core's gr prefix (grr/grn/gra/gri/grt) with zero collisions
		vim.keymap.set("n", "grc", ":Econtroller<CR>", { silent = true, desc = "go rails: controller" })
		vim.keymap.set("n", "grm", ":Emodel<CR>", { silent = true, desc = "go rails: model" })
		vim.keymap.set("n", "grv", ":Eview<CR>", { silent = true, desc = "go rails: view" })
		vim.keymap.set("n", "grh", ":Ehelper<CR>", { silent = true, desc = "go rails: helper" })
		vim.keymap.set("n", "grf", ":Efeature<CR>", { silent = true, desc = "go rails: feature" })
		vim.keymap.set("n", "grd", ":Eschema<CR>", { silent = true, desc = "go rails: schema" })
	end,
}
