-- Format on save
-- File types
local file_types = {
	"js",
	"mjs",
	"cjs",
	"jsx",
	"ts",
	"tsx",
	"html",
	"htm",
	"vue",
	"css",
	"scss",
	"less",
	"json",
	"md",
	"yaml",
	"yml",
	"gql",
	"graphql",
	"toml",
	"lua",
}

vim.cmd([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePre *.{]] .. table.concat(file_types, ",") .. [[} lua vim.lsp.buf.format()
  augroup END
]])

-- Format command
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = true }) -- Asynchronously format the buffer
end, { desc = "Format the current buffer" })

-- Auto Save
vim.cmd([[
  augroup AutoSaveOnModify
    autocmd!
    autocmd BufLeave * if &modified | silent! write | endif
    autocmd FocusLost * if &modified | silent! write | endif
  augroup END
]])
