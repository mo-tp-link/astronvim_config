return {
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- {
  --   "shaunsingh/nord.nvim",
  --   name = "nord",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- vim.g.nord_disable_background = true
  --   end,
  -- },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   name = "nordic",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("nordic").setup {
  --       -- This callback can be used to override the colors used in the base palette.
  --       -- on_palette = function(palette) end,
  --       -- This callback can be used to override the colors used in the extended palette.
  --       -- after_palette = function(palette) end,
  --       -- This callback can be used to override highlights before they are applied.
  --       -- on_highlight = function(highlights, palette) end,
  --       -- Enable bold keywords.
  --       bold_keywords = true,
  --       -- Enable italic comments.
  --       italic_comments = true,
  --       -- Enable editor background transparency.
  --       transparent = {
  --         -- Enable transparent background.
  --         bg = true,
  --         -- Enable transparent background for floating windows.
  --         float = true,
  --       },
  --       -- Enable brighter float border.
  --       bright_border = false,
  --       -- Reduce the overall amount of blue in the theme (diverges from base Nord).
  --       reduced_blue = false,
  --       -- Swap the dark background with the normal one.
  --       swap_backgrounds = false,
  --       -- Cursorline options.  Also includes visual/selection.
  --       cursorline = {
  --         -- Bold font in cursorline.
  --         bold = true,
  --         -- Bold cursorline number.
  --         bold_number = false,
  --         -- Available styles: 'dark', 'light'.
  --         theme = "light",
  --         -- Blending the cursorline bg with the buffer bg.
  --         blend = 0.85,
  --       },
  --       -- noice = {
  --       --   -- Available styles: `classic`, `flat`.
  --       --   style = "classic",
  --       -- },
  --       -- telescope = {
  --       --   -- Available styles: `classic`, `flat`.
  --       --   style = "flat",
  --       -- },
  --       -- leap = {
  --       --   -- Dims the backdrop when using leap.
  --       --   dim_backdrop = false,
  --       -- },
  --       ts_context = {
  --         -- Enables dark background for treesitter-context window
  --         dark_background = true,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   name = "kanagawa",
  --   priority = 1000,
  --   config = function()
  --     -- Default options:
  --     require("kanagawa").setup {
  --       compile = false, -- enable compiling the colorscheme
  --       undercurl = true, -- enable undercurls
  --       commentStyle = { italic = true },
  --       functionStyle = {},
  --       keywordStyle = { italic = true },
  --       statementStyle = { bold = true },
  --       typeStyle = {},
  --       transparent = false, -- do not set background color
  --       dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  --       terminalColors = false, -- define vim.g.terminal_color_{0,17}
  --       colors = { -- add/modify theme and palette colors
  --         palette = {},
  --         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --       },
  --       overrides = function(colors) -- add/modify highlights
  --         return {}
  --       end,
  --       theme = "wave", -- Load "wave" theme
  --       background = { -- map the value of 'background' option to a theme
  --         dark = "wave", -- try "dragon" !
  --         light = "lotus",
  --       },
  --     }
  --   end,
  -- },
  --
  -- {
  --   "Yazeed1s/oh-lucy.nvim",
  --   name = "lucy",
  --   priority = 1000,
  --   config = function ()
  --
  --   end
  -- },
  {
    "sam4llis/nvim-tundra",
    name = "tundra",
    priority = 1000,
    opts = {
      transparent_background = true,
      dim_inactive_windows = {
        enabled = false,
        color = nil,
      },
      sidebars = {
        enabled = true,
        color = nil,
      },
      editor = {
        search = {},
        substitute = {},
      },
      syntax = {
        booleans = { bold = true, italic = true },
        comments = { bold = true, italic = true },
        conditionals = {},
        constants = { bold = true },
        fields = {},
        functions = {},
        keywords = {},
        loops = {},
        numbers = { bold = true },
        operators = { bold = true },
        punctuation = {},
        strings = {},
        types = { italic = true },
      },
      diagnostics = {
        errors = {},
        warnings = {},
        information = {},
        hints = {},
      },
      plugins = {
        lsp = true,
        semantic_tokens = true,
        treesitter = true,
        telescope = true,
        nvimtree = true,
        cmp = true,
        context = true,
        dbui = true,
        gitsigns = true,
        neogit = true,
        textfsm = true,
      },
      overwrite = {
        colors = {},
        highlights = {},
      },
    },
  },
}
