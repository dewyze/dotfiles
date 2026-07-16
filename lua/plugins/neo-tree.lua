return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "main", -- v3.x froze at 3.40; development (incl. quick_jump) lives on main
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		vim.keymap.set("n", "<C-s><C-s>", ":Neotree toggle<CR>", { silent = true, desc = "show: file tree" })
		vim.keymap.set("n", "<C-s><C-f>", ":Neotree reveal<CR>", { silent = true, desc = "show: reveal current file" })

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
          -- stock quick_jump sits on <C-s> (nowait), which would eat the
          -- C-s drawer chord inside the tree; move it to C-j (squatter rule)
          ["<C-s>"] = "none",
          ["<C-j>"] = {
            "quick_jump",
            config = {
              on_jump = "open_or_toggle",
              jump_labels = "jfkdlsahgnuvrbytmiceoxwpqz",
            },
          },
        },
      },
    })
	end,
}
