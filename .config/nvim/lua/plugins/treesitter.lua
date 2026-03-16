return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"lua",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
}
