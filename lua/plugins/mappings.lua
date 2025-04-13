return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      mappings = {
        -- first key is the mode
        i = {
          ["jk"] = { "<ESC>", desc = "Escape insert mode" },
        },
        n = {
          -- second key is the lefthand side of the map

          -- -- navigate buffer tabs
          ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

          -- -- mappings seen under group name "Buffer"
          -- ["<Leader>bd"] = {
          --   function()
          --     require("astroui.status.heirline").buffer_picker(
          --       function(bufnr) require("astrocore.buffer").close(bufnr) end
          --     )
          --   end,
          --   desc = "Close buffer from tabline",
          -- },
          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { desc = "Buffers" },

          -- setting a mapping to false will disable it
          -- ["<C-S>"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      -- mappings to be set up on attaching of a language server
      mappings = {
        n = {
          -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
          -- gD = {
          --   function() vim.lsp.buf.declaration() end,
          --   desc = "Declaration of current symbol",
          --   cond = "textDocument/declaration",
          -- },
          ["<Leader>lY"] = {
            function() require("astrolsp.toggles").buffer_semantic_tokens() end,
            desc = "Toggle LSP semantic highlight (buffer)",
            cond = function(client)
              return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
            end,
          },
          -- ["<leader>lr"] = {
          --   function() vim.lsp.buf.rename() end,
          --   desc = "LSP Rename",
          --   cond = "textDocument/rename",
          -- },
          -- ["<leader>lt"] = {
          --   function() vim.lsp.buf.type_definition() end,
          --   desc = "LSP Type Definition",
          --   cond = "textDocument/typeDefinition",
          -- },
          -- ["<leader>la"] = {
          --   function() vim.lsp.buf.code_action() end,
          --   desc = "LSP Code Action",
          --   cond = "textDocument/codeAction",
          -- },
          -- ["<leader>lD"] = {
          --   function() vim.lsp.buf.declaration() end,
          --   desc = "LSP Declaration",
          --   cond = "textDocument/declaration",
          -- },
          -- ["<leader>ld"] = {
          --   function() vim.lsp.buf.definition() end,
          --   desc = "LSP Definition",
          --   cond = "textDocument/definition",
          -- },
          -- ["<leader>li"] = {
          --   function() vim.lsp.buf.implementation() end,
          --   desc = "LSP Implementation",
          --   cond = "textDocument/implementation",
          -- },
          -- ["<leader>lR"] = {
          --   function() vim.lsp.buf.references() end,
          --   desc = "LSP References",
          --   cond = "textDocument/references",
          -- },
        },
      },
    },
  },
}
