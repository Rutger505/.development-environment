return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
			},
			automatic_installation = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Set capabilities globally for all servers
			vim.lsp.config("*", { capabilities = capabilities })

			-- Enable all servers installed via mason-lspconfig
			vim.lsp.enable(require("mason-lspconfig").get_installed_servers())

			-- Keymaps on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end
					map("gd", vim.lsp.buf.definition, "Go to Definition")
					map("gr", vim.lsp.buf.references, "Go to References")
					map("K", vim.lsp.buf.hover, "Hover Docs")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>gd", vim.lsp.buf.declaration, "Go to Declaration")
				end,
			})
		end,
	},
}
