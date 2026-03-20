return {
	{
		"aklt/plantuml-syntax",
		ft = { "plantuml" },
	},

	{
		"https://gitlab.com/itaranto/preview.nvim",
		version = "*",
		ft = { "plantuml" },
		opts = {
			previewers_by_ft = {
				plantuml = {
					name = "plantuml_svg",
					renderer = { type = "imv" },
				},
			},
			render_on_write = true,
		},
	},
}
