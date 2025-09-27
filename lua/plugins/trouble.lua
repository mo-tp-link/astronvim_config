return {
  "folke/trouble.nvim",
  enabled = true,
  event = "BufEnter",
  opts = {
    modes = {
      mydiags = {
        mode = "diagnostics",
        auto_open = true,
        -- auto_close = true,
        win = {
          position = "bottom", -- Set window position to right
          size = { height = 7 },
        },
        filter = {
          any = {
            buf = 0,
            {
              severity = vim.diagnostic.severity.ERROR,
              function(item) return item.filename:find((vim.loop or vim.uv).cwd(), 1, true) end,
            },
          },
        },
      },
    },
  },
}
