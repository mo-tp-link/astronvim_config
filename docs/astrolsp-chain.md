# AstroLSP / Mason / lspconfig 完整调用链

## 概览

```
Mason（安装二进制）
    ↓
mason-lspconfig（映射表：包名 ↔ lspconfig server name）
    ↓
astrolsp.lsp_setup(server)
    ↓
lspconfig[server].setup(opts)
    ↓
LSP 客户端 attach 到 buffer → on_attach
```

---

## 每一层的职责

### 1. Mason
只负责**下载和安装二进制**到 `~/.local/share/nvim/mason/bin/`。
它不知道 neovim LSP 怎么用，也不知道 lspconfig。

### 2. mason-lspconfig
维护一张**双向映射表**：
```
mason 包名          ←→  lspconfig server name
"pyright"           ←→  "pyright"
"ruff"              ←→  "ruff"
"lua-language-server" ←→ "lua_ls"
```

启动时遍历 Mason 已安装的包，对每个包查映射表，找到对应的 lspconfig
server name 后，调用注册的 handler：

```lua
-- AstroNvim 注册的 handler（在 lspconfig.lua 里）
handlers = {
    function(server) require("astrolsp").lsp_setup(server) end
}
```

**关键**：如果某个包不在映射表里，这里直接跳过，`lsp_setup` 永远不会被调用。

### 3. astrolsp.lsp_setup(server)
真正做设置的地方，逻辑如下：

```lua
function M.lsp_setup(server)
    -- 1. lspconfig 有没有内置定义？
    local config_avail, config = pcall(require, "lspconfig.configs." .. server)

    if not config_avail or not config.default_config then
        -- 没有内置定义 → 检查 astrolsp config[server] 有没有 cmd
        local server_definition = M.config.config[server]
        if server_definition and server_definition.cmd then
            -- 有 cmd → 自动注册到 lspconfig
            require("lspconfig.configs")[server] = { default_config = server_definition }
        end
    end

    -- 2. 合并 opts（capabilities + flags + config[server]）
    opts = M.lsp_opts(server)

    -- 3. 调用 handler 或默认 setup
    local handler = vim.F.if_nil(
        M.config.handlers[server],  -- 用户自定义 handler
        M.config.handlers[1],       -- 默认 handler（通常是 nil）
        default_handler             -- 兜底：lspconfig[server].setup(opts)
    )
    handler(server, opts)
end
```

### 4. lspconfig[server].setup(opts)
最终调用，建立 LSP 客户端，监听文件类型事件，文件打开时启动 LSP 进程并 attach。

---

## astrolsp 的 `config` 和 `handlers`

### `config[server]`
传给 `lspconfig[server].setup()` 的**选项**，会被 `tbl_deep_extend` 合并进 opts。
可以放任何 lspconfig 支持的字段：

```lua
config = {
    ruff = {
        init_options = {          -- LSP 协议的初始化参数
            settings = { ... }
        }
    },
    pyright = {
        settings = {              -- 服务器自己的设置
            python = { analysis = { ... } }
        }
    },
    zuban = {
        cmd = { "zuban", "server" },   -- 有 cmd → 触发自动注册
        filetypes = { "python" },
        root_dir = function(fname) ... end,
    }
}
```

**特殊规则**：对于 lspconfig **没有内置定义**的服务器，`config[server]` 里必须有
`cmd` 字段，AstroLSP 才会自动把它注册到 `lspconfig.configs`。

### `handlers[server]`
**替换**默认的 `lspconfig[server].setup(opts)` 调用。只在需要自定义注册逻辑
时才用，例如：

```lua
handlers = {
    -- 在 setup 前动态修改 opts
    some_server = function(_, opts)
        opts.cmd = pick_cmd_based_on_env()
        require("lspconfig").some_server.setup(opts)
    end,
}
```

**不需要 handler 的情况**：只是传配置选项 → 放 `config` 就够。
以下这些都是多余的（和默认行为完全一样）：

```lua
-- ❌ 多余
ruff = function(_, opts) require("lspconfig").ruff.setup(opts) end,
pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end,
```

### `servers` 列表
直接调用 `lsp_setup`，**绕过 mason-lspconfig 的映射表检查**：

```lua
-- astronvim/plugins/configs/lspconfig.lua
for _, server in ipairs(astrolsp.config.servers) do
    astrolsp.lsp_setup(server)
end
```

**必须加入 `servers` 的情况**：服务器不在 mason-lspconfig 映射表里。

### `on_attach`
每次 LSP 客户端 attach 到 buffer 时执行，提供 `client` 和 `bufnr`：

```lua
on_attach = function(client, bufnr)
    -- 禁用某个 server 的特定 capability
    if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
    end
    -- 设置 buffer-local keymap
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
end
```

---

## Case：zuban（不在 mason-lspconfig 映射表里的服务器）

### 问题现象
Mason 安装了 zuban，但 LSP 没有启动。

### 原因分析

```
Mason 已安装 zuban ✅
    ↓
mason-lspconfig 遍历已安装包：
    registry.get_installed_package_names() → [..., "zuban", ...]
    ↓
    查映射表：server_mapping.package_to_lspconfig["zuban"] → nil ❌
    ↓
    跳过，lsp_setup 永远不被调用
```

zuban 是通过 `pip install zuban` 安装的第三方工具，
**从未被收录进 mason-lspconfig 的映射表**，也没有 lspconfig 的内置定义。

### 解决方案

```lua
-- astrolsp.lua

-- 1. 加入 servers，绕过 mason-lspconfig
servers = { "zuban" },

-- 2. 在 config 里提供 cmd（触发 AstroLSP 自动注册到 lspconfig）
config = {
    zuban = {
        cmd = { "zuban", "server" },    -- ← 关键，没有这个注册不了
        filetypes = { "python" },
        root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
                "pyproject.toml", "setup.py", "setup.cfg", ".git"
            )(fname)
        end,
        single_file_support = true,
    },
}

-- handler 不需要，默认行为已够用
```

### 最终状态

| 层 | 状态 | 说明 |
|----|------|------|
| Mason | ✅ 已安装 | `~/.local/share/nvim/mason/bin/zuban` |
| mason-lspconfig 映射表 | ❌ 不存在 | zuban 从未被收录 |
| lspconfig 内置定义 | ❌ 不存在 | 需要手动注册 |
| `astrolsp.servers` | ✅ 手动加入 | 绕过 mason-lspconfig，直接触发 lsp_setup |
| `config.zuban.cmd` | ✅ 已提供 | AstroLSP 自动注册到 lspconfig.configs |

### 完整调用链（zuban）

```
astrolsp.config.servers = ["zuban"]
    ↓  (lspconfig.lua 遍历 servers)
astrolsp.lsp_setup("zuban")
    ↓
lspconfig.configs["zuban"] 不存在
    ↓
config["zuban"].cmd 存在 → 自动注册：
    lspconfig.configs["zuban"] = { default_config = config["zuban"] }
    ↓
lsp_opts("zuban")  → 合并 capabilities + config["zuban"]
    ↓
default_handler → lspconfig.zuban.setup(opts)
    ↓
打开 .py 文件 → zuban server 启动 → on_attach
```

---

## 快速判断表

| 情况 | 需要什么 |
|------|---------|
| 标准服务器（pyright、ruff 等） | 只需 `config[server]` |
| 不在 mason-lspconfig 映射里 | `servers` 列表 + `config[server].cmd` |
| 需要在 setup 前做动态逻辑 | `handlers[server]` |
| 需要按 buffer/client 做操作 | `on_attach` |
