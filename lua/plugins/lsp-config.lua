return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {"lua_ls" }
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.elmls.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.ruby_lsp.setup({
				on_attach = function(client)
					client.server_capabilities.semanticTokensProvider = false
				end,
			})
			lspconfig.sorbet.setup({
				cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
				root_dir = lspconfig.util.root_pattern("sorbet/config"),
			})
			lspconfig.tsserver.setup({})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	 				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<space>n', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '<space>p', vim.diagnostic.goto_prev, opts)
          -- vim.keymap.set('n', '<space>f', function()
          --   vim.lsp.buf.format { async = true }
          -- end, opts)
				end,
			})
		end,
	},
}
