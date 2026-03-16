return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      lazygit = { enabled = true },
      scroll  = {
        enabled = true,
        animate = {
          duration = { step = 10, total = 100 },
          easing = "linear",
        },
        animate_repeat = {
          delay = 50,
          duration = { step = 3, total = 20 },
          easing = "linear",
        },
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "LazyGit"
      },
    },
  },
}
