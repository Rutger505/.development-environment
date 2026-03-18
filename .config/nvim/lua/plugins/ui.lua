-- lua/plugins/ui.lua
return {
  { "nvim-tree/nvim-web-devicons" },

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
    lazy = false,
    config = function()
      require("mini.statusline").setup({
        use_icons = true,
        content = {
          active = function()
            local sl = require("mini.statusline")
            local mode, mode_hl = sl.section_mode({ trunc_width = 120 })
            local git           = sl.section_git({ trunc_width = 75 })
            local diagnostics   = sl.section_diagnostics({ trunc_width = 75 })
            local filename      = vim.fn.expand("%:~:.")
            local fileinfo      = sl.section_fileinfo({ trunc_width = 120 })
            local location      = sl.section_location({ trunc_width = 75 })

            return sl.combine_groups({
              { hl = mode_hl,                  strings = { mode } },
              { hl = "MiniStatuslineDevinfo",  strings = { git, diagnostics } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl,                  strings = { location } },
            })
          end,
          inactive = function()
            local sl = require("mini.statusline")
            local filename = vim.fn.expand("%:~:.")
            return sl.combine_groups({
              { hl = "MiniStatuslineFilename", strings = { filename } },
            })
          end,
        },
      })
    end,
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        require("notify").setup({
            stages = "static",
            render = "minimal",
        })
        vim.notify = require("notify")
    end,
  },
}
