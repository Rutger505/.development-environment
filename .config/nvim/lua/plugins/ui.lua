-- lua/plugins/ui.lua
return {
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
    },
  },

  {
    "echasnovski/mini.statusline",
    version = "*",
    opts = { use_icons = true },
  },

  {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            stages = "static",
            render = "minimal",
        })
        vim.notify = require("notify")
    end,
  },
}
