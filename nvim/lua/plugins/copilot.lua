return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true -- Disable the default tab mapping
			vim.api.nvim_set_keymap("i", "<C-]>", 'copilot#Accept("")', { expr = true, silent = true }) -- Map Ctrl + ] to confirm suggestions
		end,
	},
}
