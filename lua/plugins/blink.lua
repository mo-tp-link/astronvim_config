-- lua/plugins/blink.lua
return {
  "Saghen/blink.cmp",
  opts = {
    -- Custom keymaps based on your nvim-cmp configuration
    keymap = {
      preset = "none",
      -- Navigation
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      ["<C-e>"] = { "show_documentation", "hide_documentation", "fallback" },
      -- Documentation scrolling
      ["<C-d>"] = { function(cmp) cmp.scroll_documentation_down(4) end, "fallback" },
      ["<C-u>"] = { function(cmp) cmp.scroll_documentation_up(4) end, "fallback" },
      -- Close completion menu
      ["<Esc>"] = { "hide", "fallback" },
      -- Enter key behavior
      ["<CR>"] = { "cancel", "fallback" },
      -- Tab key behavior - using blink.cmp functions
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          else
            return cmp.select_and_accept()
          end
        end,
        "fallback",
      },
    },
    -- Configure your sources
    cmdline = {
      keymap = {
        preset = "inherit",
        ["<CR>"] = { "select_accept_and_enter", "fallback" },
      },
      completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
    },
    sources = {
      -- Add your sources to the default list
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "omni",
        -- "calc",
        -- "otter",
        -- "pandoc_references",
        -- "spell",
        -- "treesitter",
        -- "latex_symbols",
        -- "emoji",
        -- "obsidian",
      },
      -- providers = {
      --   -- Configure each provider with options corresponding to your current setup
      --   otter = {
      --     filetypes = { "qmd" },
      --   },
      --   lsp = {
      --     score_offset = 0, -- Higher priority
      --   },
      --   snippets = {
      --     keyword_length = 3,
      --     max_item_count = 3,
      --     score_offset = -1,
      --   },
      --   buffer = {
      --     keyword_length = 5,
      --     max_item_count = 3,
      --     score_offset = -3, -- Lower priority
      --   },
      --   treesitter = {
      --     keyword_length = 5,
      --     max_item_count = 3,
      --   },
      --   obsidian = {
      --     filetypes = { "md" },
      --   },
      -- },
    },
    --   -- For compatibility with any nvim-cmp sources you're using
    -- specs = {
    --   { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
    -- },
    -- -- Add dependencies for any non-blink sources
    -- dependencies = {
    --   "hrsh7th/cmp-nvim-lsp-signature-help",
    --   "hrsh7th/cmp-path",
    --   "hrsh7th/cmp-buffer",
    --   "hrsh7th/cmp-calc",
    --   "saadparwaiz1/cmp_luasnip",
    --   "kdheepak/cmp-latex-symbols",
    --   "hrsh7th/cmp-emoji",
    -- },
  },
}
