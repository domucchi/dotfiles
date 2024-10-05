return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"yaml",
					"toml",
					"bash",
					"python",
					"lua",
				},
				highlight = { enable = true },
				indent = { enable = true },
				auto_install = true,
				sync_install = false,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
}
