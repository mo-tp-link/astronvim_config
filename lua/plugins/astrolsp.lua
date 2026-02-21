-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = false,
      inlay_hints = true, -- ty 提供类型 inlay hints
      semantic_tokens = false,
      signature_help = true,
    },
    formatting = {
      format_on_save = {
        allow_filetypes = { "python" }, -- 只有 ruff 负责格式化
      },
      disabled = { "pyright", "ty" }, -- ty 不格式化，明确禁用
      timeout_ms = 3200,
    },
    -- ty 不在 mason-lspconfig 映射里，需要手动声明
    servers = {
      --"ty"
    },
    ---@diagnostic disable: missing-fields
    config = {
      marksman = { filetypes = { "markdown", "quarto", "qmd" } },

      -- ── ty：类型检查 + 语言服务（hover / goto-def / refs / completions）──
      -- ty = {
      --
      --   cmd = { "ty", "server" },
      --   filetypes = { "python" },
      --   -- root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
      --   root_dir = function(fname)
      --     return require("lspconfig.util").root_pattern("ty.toml", "pyproject.toml", "setup.py", "setup.cfg", ".git")(
      --       fname
      --     )
      --   end,
      -- },

      -- ── ruff：lint + 格式化（black + isort 替代品）──
      -- 注意：ruff 用 init_options.settings，不是顶层 settings
      pyright = {
        -- 1. 严格遵守 Pyright 规范，必须包在 settings 里面
        settings = {
          pyright = {
            disableOrganizeImports = true, -- 交给 Ruff
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
            exclude = {
              "**/node_modules",
              "**/__pycache__",
              ".venv",
              "venv",
              "build",
              "dist",
              ".git",
            },
            -- 注意：这里不要写死 venvPath，交由下方的 on_new_config 动态注入
          },
        },
      },
      ruff = {
        settings = {
          lineLength = 88,
          organizeImports = true, -- 启用 source.organizeImports.ruff
          fixAll = true, -- 启用 source.fixAll.ruff
          lint = {
            enable = true,
            select = {
              "E", -- pycodestyle errors
              "F", -- pyflakes（未使用变量/import）
              "UP", -- pyupgrade（自动升级旧语法）
              "I", -- isort（import 排序）
              "N", -- pep8-naming
              "B", -- flake8-bugbear（常见 bug 模式）
              "SIM", -- flake8-simplify（简化冗余代码）
              "RUF", -- ruff 专属规则
            },
            unsafeFixes = true, -- 允许修复 RUF002 等 unsafe fix 规则
          },
        },
      },
    },
    handlers = {
      pyright = function(_, opts)
        opts.settings.python.pythonPath = vim.fn.getcwd() .. "/.venv/bin/python"
        require("lspconfig").pyright.setup(opts)
      end,

      -- ty 需要手动注册（lspconfig 尚无内置定义）
      -- AstroLSP 会自动从 config.ty 生成 lspconfig.configs.ty，然后调用 setup
      -- ty = function(_, opts)
      --   opts.init_options = {
      --     logLevel = "warn",
      --
      --     showSyntaxErrors = true,
      --     disableLanguageServices = true,
      --     single_file_support = true,
      --     diagnosticMode = "openFilesOnly",
      --   }
      --
      --   require("lspconfig").ty.setup(opts)
      -- end,
      -- ruff handler 精简，settings 统一放在 config.ruff.init_options 里
      ruff = function(_, opts)
        opts.init_options = {
          settings = {
            format = {
              ["quote-style"] = "double",
              ["indent-style"] = "space",
              ["line-ending"] = "auto",
            },
          },
        }

        require("lspconfig").ruff.setup(opts)
      end,
    },
    on_attach = function(client, bufnr)
      -- ruff 不提供 hover（由 ty 负责），禁用避免冲突
      if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
    end,
  },
}
