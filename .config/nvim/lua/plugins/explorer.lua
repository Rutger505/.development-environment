return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			window = {
				mappings = {
					["<space>"] = "noop",
				},
			},
			filesystem = {
				hijack_netrw_behavior = "open_current",
			},
		},
	},
}

