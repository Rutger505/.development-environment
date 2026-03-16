return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
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
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Automatically set up all servers installed via mason-lspconfig
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({ capabilities = capabilities })
				end,
			})

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
