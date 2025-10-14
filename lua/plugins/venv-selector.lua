return {
  "linux-cultist/venv-selector.nvim",
  enabled = false,
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
    -- "nvim-telescope/telescope.nvim",
    -- "mfussenegger/nvim-dap-python",
  },
  ft = { "python" },
  keys = {
    { "<leader>fe", desc = "EnvSelect" },
    { "<leader>fee", "<cmd>VenvSelect<cr>", desc = "VenvSelect" },
    { "<leader>fec", "<cmd>VenvSelectCached<cr>", desc = "VenvSelectCached" },
  },
  opts = {
    settings = {
      search = {
        anaconda_base = {
          command = "fd --full-path 'bin/python$' /home/mo/miniconda3/envs/",
          type = "anaconda",
        },
      },
    },
  },
}
