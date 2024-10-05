return {
	{
		"ibhagwan/fzf-lua",
		requires = { "junegunn/fzf" }, -- Make sure fzf is installed
		config = function()
			require("fzf-lua").setup({
				winopts = {
					height = 0.85, -- Height of the fzf window
					width = 0.85, -- Width of the fzf window
					border = "rounded", -- Options for border (single, double, rounded, or none)
				},
			})
		end,
	},
}
