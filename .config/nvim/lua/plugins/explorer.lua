return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		init = function()
			vim.api.nvim_create_autocmd({ "VimEnter", "TabNew" }, {
				callback = function()
					vim.cmd("Neotree show")
				end,
			})
		end,
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
				hijack_netrw_behavior = "disabled",
			},
		},
	},
}

