return {
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- Optional if you want file icons
		config = function()
			vim.opt.laststatus = 3
			require("lualine").setup({
				options = {
					theme = "auto", -- You can specify a theme or 'auto'
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename", "diagnostics" },
					lualine_x = { "filetype" },
					lualine_y = { "encoding" },
					lualine_z = { "progress", "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}
