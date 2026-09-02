-- Minimal init for headless plenary tests:
--   nvim --headless -u nvim/tests/minimal_init.lua -c "PlenaryBustedFile <spec>"
-- Repo-relative rtp so tests don't depend on the ~/.config/nvim symlink.
local nvim_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h")
vim.opt.rtp:prepend(nvim_root)
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/plenary.nvim")
