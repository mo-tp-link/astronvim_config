-- Create a plugins/aerial.lua file
return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    -- Add filetype specific settings
    opts.filter_kind = opts.filter_kind or {}

    -- Configure aerial.nvim to show only markdown headings for qmd files
    opts.filter_kind.qmd = {
      "Module", -- For markdown sections
      "Class", -- For markdown headers
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Method",
      "Struct",
      "Variable",
      "Constant",
      "Property",
      "Heading", -- Explicit heading kind
      "Title", -- Some LSPs use title
    }

    -- Set priority for markdown LSP
    opts.lsp = opts.lsp or {}
    opts.lsp.priority = opts.lsp.priority or {}
    opts.lsp.priority.qmd = {
      "marksman", -- Prioritize marksman LSP for qmd files
      "pyright", -- Then other LSPs
      "null-ls",
    }

    -- Force markdown backends for qmd files
    opts.backends = opts.backends or {}
    opts.backends.qmd = { "lsp", "treesitter", "markdown" }

    return opts
  end,
}
