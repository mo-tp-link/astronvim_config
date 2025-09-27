return {
  "folke/trouble.nvim",
  -- enabled = false,
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
  config = function(_, opts)
    require("trouble").setup(opts)

    -- Override highlight groups
    vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "none" })
  end,
}
