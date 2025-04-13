return {
  "quarto-dev/quarto-nvim",
  dev = false,
  dependencies = {
    "jmbuhr/otter.nvim",
  },
  ft = { "quarto" },
  opts = {
    debug = false,
    closePreviewOnExit = true,
    lspFeatures = {
      enabled = true,
      chunks = "curly",
      languages = { "python", "r", "julia" },
      diagnostics = {
        enabled = true,
        triggers = { "BufWritePost" },
      },
      completion = {
        enabled = true,
      },
    },
    codeRunner = {
      enabled = true,
      default_method = "iron", -- "molten", "slime", "iron" or <function>
      ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
      never_run = { "yaml" }, -- filetypes which are never sent to a code runner
    },
  },
}
