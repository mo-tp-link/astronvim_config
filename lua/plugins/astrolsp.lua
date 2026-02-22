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
      disabled = { "pyright", "ty", "zuban" }, -- ty 不格式化，明确禁用
      timeout_ms = 3200,
    },
    -- 不在 mason-lspconfig 映射里的服务器需要手动声明
    servers = {
      "zuban",
      "ty",
    },
    ---@diagnostic disable: missing-fields
    config = {
      -- INFO: 各家config都不一样 具体取决于doc
      marksman = { filetypes = { "markdown", "quarto", "qmd" } },
      ty = {
        -- enabled = false,
        cmd = { "ty", "server" },
        filetypes = { "python" },
        -- root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("ty.toml", "pyproject.toml", "setup.py", "setup.cfg", ".git")(
            fname
          )
        end,
        settings = {
          showSyntaxErrors = true,
          diagnosticMode = "openFilesOnly",
          configuration = {},
        },
        init_options = { logLevel = "warn" },
      },

      zuban = {
        enabled = false,
        cmd = { "zuban", "server" },
        filetypes = { "python" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("pyproject.toml", "setup.py", "setup.cfg", ".git")(fname)
        end,
        single_file_support = true,
      },

      ruff = {
        init_options = { -- 不是必须要用setting
          settings = {
            logLevel = "warn",
            lineLength = 88,
            organizeImports = true,
            fixAll = true,
            lint = {
              select = {
                "E", -- pycodestyle errors
                "F", -- pyflakes（未使用变量/import）
                "UP", -- pyupgrade（自动升级旧语法）
                "I", -- isort（import 排序）
                "N", -- pep8-naming
                "B", -- flake8-bugbear（常见 bug 模式）
                "SIM", -- flake8-simplify（简化冗余代码）
                "RUF", -- ruff 专属规则
                "ARG", -- Unused arguments
                "PL", -- pylink
              },
            },
            format = { preview = false }, -- 只有 preview/backend 是 LSP 直接选项
            -- ruff 工具配置（等价于 ruff.toml 内容）放在 configuration 下，kebab-case
            configuration = {
              ["indent-width"] = 4, -- 顶层，不在 format 下
              format = {
                ["quote-style"] = "double",
                ["indent-style"] = "space", -- tab
                ["line-ending"] = "auto",
              },
            },
          },
        },
      },

      pyright = {
        --INFO: enabled = false关闭
        enabled = false,
        settings = {
          pyright = {
            -- disableLanguageServices = true,
            disableOrganizeImports = true, -- 交给 Ruff
          },
          python = {
            pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",

            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "standard",
              -- 关掉与 ruff 重叠的规则，避免重复报告
              diagnosticSeverityOverrides = {
                reportUnusedImport = "none", -- ruff F401
                reportUnusedVariable = "none", -- ruff F841
                reportUnusedParameter = "none", -- ruff ARG
                reportUnusedExpression = "none", -- ruff B
                reportUnusedFunction = "information",
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
              logLevel = "Warning",
            },
          },
        },
      },
    },
    handlers = {
      -- INFO: 需要在setup前做动态逻辑， 或者服务器不在lspconfig里 或者没有插件配置才需要放在这里使用
      --
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end,
      -- ruff = function(_, opts) require("lspconfig").ruff.setup(opts) end,
      -- ty = function(_, opts) require("lspconfig").ty.setup(opts) end,
    },
    on_attach = function(client, bufnr)
      -- INFO: 提供client和buffer参数， client 和buffer相关的放在这里

      -- ruff 不提供 hover（由 ty 负责），禁用避免冲突
      if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
    end,
  },
}
