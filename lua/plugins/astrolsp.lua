-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = false, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
      signature_help = false,
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
          "python",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
        -- "pyright",
      },
      timeout_ms = 3200, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright",
      -- "ruff",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      marksman = { filetypes = { "markdown", "quarto", "qmd" } },
      ty = { filetype = { "python", "py" } },
      -- ruff = { filetype = { "python", "py" } },
      -- pyright = {
      --   settings = {
      --     pyright = {
      --       disableOrganizeImports = true,
      --     },
      --     python = {
      --       analysis = {
      --         ignore = { "*" },
      --       },
      --     },
      --   },
      -- },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end, -- or a custom handler function can be passed
      -- ruff = function(_, opts) require("lspconfig").ruff.setup(opts) end,
      -- pyright = function(_, opts)
      --   -- Try to detect .venv created by uv or venv
      --   local cwd = vim.fn.getcwd()
      --   local venv_python = cwd .. "/.venv/bin/python"
      --
      --   if vim.fn.executable(venv_python) == 1 then
      --     opts.settings = opts.settings or {}
      --     opts.settings.python = opts.settings.python or {}
      --     opts.settings.python.pythonPath = venv_python
      --     vim.g.python3_host_prog = venv_python
      --   else
      --     vim.notify("No .venv found for Pyright, using system Python", vim.log.levels.WARN)
      --   end
      --
      --   require("lspconfig").pyright.setup(opts)
      -- end,
      ty = function(_, opts) require("lspconfig").ty.setup(opts) end,

      -- ruff = function(_, opts)
      --   -- Ruff doesn’t need pythonPath, but good to ensure it uses same root
      --   require("lspconfig").ruff.setup(opts)
      -- end,
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      --
    end,
  },
}
