return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python",
  },
  keys = {
    { "<leader>zs", "<cmd>VenvSelect<cr>" },
    { "<leader>zc", "<cmd>VenvSelectCached<cr>" },
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
