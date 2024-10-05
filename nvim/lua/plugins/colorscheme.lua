return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		priority = 1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
			})
			require("notify").setup({
				background_colour = "#1e222a",
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
