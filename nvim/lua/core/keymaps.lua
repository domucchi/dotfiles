local fzf_lua = require("fzf-lua")

local map = vim.keymap.set
local defaults = { noremap = true, silent = true }

map("n", "<leader>hh", "<C-w>h", defaults)
map("n", "<leader>jj", "<C-w>j", defaults)
map("n", "<leader>kk", "<C-w>k", defaults)
map("n", "<leader>ll", "<C-w>l", defaults)

-- Oil
map("n", "<leader>e", ":Oil<CR>", defaults)

-- FZF
map("n", "<leader>ff", fzf_lua.files, { desc = "Fzf Files" })
map("n", "<leader>fg", fzf_lua.grep, { desc = "Fzf Grep" })
map("n", "<leader>fl", fzf_lua.live_grep, { desc = "Fzf Live Grep" })
map("n", "<leader>fc", fzf_lua.commands, { desc = "Fzf Commands" })
map("n", "<leader>fb", fzf_lua.buffers, { desc = "Fzf Buffers" })
map("n", "<leader>fh", "<cmd>help<CR>", defaults)

map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true }) -- Rename symbol under cursor

vim.api.nvim_set_keymap("n", "<C-k>", ":m -2<CR>==", { noremap = true, silent = true }) -- Move the current line up
vim.api.nvim_set_keymap("n", "<C-j>", ":m +1<CR>==", { noremap = true, silent = true }) -- Move the current line down
vim.api.nvim_set_keymap("n", "<leader>cl", ':nohl<CR>:let @/ = ""<CR>', { noremap = true, silent = true }) -- Clear search highlights
