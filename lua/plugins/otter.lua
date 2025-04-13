return {
  "jmbuhr/otter.nvim",
  dev = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  opts = {
    lsp = {
      hover = {
        border = "rounded",
      },
    },
    buffers = {
      set_filetype = true,
    },
  },
}
