return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  opts = {
    max_lines = 3, -- cap how tall the sticky header can get
    multiline_threshold = 1, -- collapse multi-line signatures to one line
  },
}
