return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<cmd>ZellijNavigateLeft<cr>", silent = true, desc = "navigate left or zellij" },
    { "<C-j>", "<cmd>ZellijNavigateDown<cr>", silent = true, desc = "navigate down or zellij" },
    { "<C-k>", "<cmd>ZellijNavigateUp<cr>", silent = true, desc = "navigate up or zellij" },
    { "<C-l>", "<cmd>ZellijNavigateRight<cr>", silent = true, desc = "navigate right or zellij" },
  },
  opts = {},
}
