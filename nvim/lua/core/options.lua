vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.o.relativenumber = true
vim.opt.autowrite = true
vim.o.directory = vim.fn.expand("~/.local/share/nvim/swapfiles//")
vim.opt.clipboard:append("unnamedplus")

-- Cursor
vim.opt.guicursor = {
	"n:block",
	"v:block",
	"i:ver25",
	"c:block",
}
