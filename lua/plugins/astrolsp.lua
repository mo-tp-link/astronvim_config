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
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
      signature_help = true,
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        -- enabled = true, -- enable or disable format on save globally
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
        "pyright",
      },
      timeout_ms = 3200, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "ty",
      -- "pyright",
      -- "ruff",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      marksman = { filetypes = { "markdown", "quarto", "qmd" } },
      ty = {
        cmd = { "ty", "server" },
        filetypes = { "python" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("ty.toml", "pyproject.toml", "setup.py", "setup.cfg", ".git")(fname)
        end,
        single_file_support = true,
      },
      ruff = {
        settings = {

          organizeImports = true,
          fixAll = true,
          lineLength = 88,
          lint = {
            enable = true,

            select = { "E", "F", "UP" },
          },
        },
      },
      -- pyright = {
      --   enable = false,
      --
      --   --     settings = {
      --   --       pyright = {
      --   --         disableOrganizeImports = true,
      --   --       },
      --   --       python = {
      --   --         analysis = {
      --   --           -- ignore = { "*" },
      --   --           autoSearchPaths = true,
      --   --           diagnosticMode = "openFilesOnly",
      --   --           useLibraryCodeForTypes = true,
      --   --         },
      --   --       },
      --   --     },
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
      pyright = false,
      -- pyright = function(_, opts)
      --   -- local cwd = vim.fn.getcwd()
      --   -- local venv_dir = cwd .. "/.venv"
      --
      --   --   if vim.fn.isdirectory(venv_dir) == 1 then
      --   --     opts.settings = opts.settings or {}
      --   --     opts.settings.python = opts.settings.python or {}
      --
      --   --     opts.settings.python.venvPath = cwd
      --   --     opts.settings.python.venv = ".venv"
      --
      --   --     vim.notify("Pyright using .venv from project", vim.log.levels.INFO)
      --   --   else
      --   --     vim.notify("No .venv found, using system Python", vim.log.levels.WARN)
      --   --   end
      --   --
      --   require("lspconfig").pyright.setup(opts)
      -- end,
      ty = function(_, opts) require("lspconfig").ty.setup(opts) end,
      ruff = function(_, opts)
        -- Ruff LSP 设置
        opts.init_options = {
          settings = {
            configuration = {
              format = {
                ["quote-style"] = "single",
              },
            },
          },
        }
        require("lspconfig").ruff.setup(opts)
      end,
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      if client.name == "ruff" then client.server_capabilities.colorProvider = false end
    end,
  },
}
