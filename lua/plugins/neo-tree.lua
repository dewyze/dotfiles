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

    require("neo-tree").setup({
      filesystem = {
        window = {
          mappings = {
            -- disable fuzzy finder
            ["/"] = "noop"
          }
        }
      },
      window = {
        mappings = {
          ["m"] = {
            "move",
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "relative" -- "none", "relative", "absolute"
            }
          },
        },
      },
    })
	end,
}
