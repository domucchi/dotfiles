return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp", -- Autocompletion plugin
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- Path completions
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"L3MON4D3/LuaSnip", -- Snippet engine
			"jose-elias-alvarez/null-ls.nvim", -- LSP for formatting, linting, etc.
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			local lspconfig = require("lspconfig")
			local cmp = require("cmp")
			local null_ls = require("null-ls")

			-- -- Set up null-ls
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
				},
			})

			-- Completion settings
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For luasnip users.
					end,
				},
				mapping = {
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<S-Space>"] = cmp.mapping.complete(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				},
			})

			-- Set up language servers
			lspconfig.ts_ls.setup({})
			lspconfig.tailwindcss.setup({})
		end,
	},
}
