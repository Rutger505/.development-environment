return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		},
		opts = {},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {},
	},

	{
		"NMAC427/guess-indent.nvim",
		event = "BufReadPost",
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"echasnovski/mini.trailspace",
		version = "*",
		event = "BufReadPre",
		opts = {},
	},
 
	{
		"stevearc/conform.nvim",
		event = "bufwritepre",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer (or selection)",
			},
		},
		opts = {},
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions" },
		},
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo Comments" },
		},
		opts = {},
	},
}
