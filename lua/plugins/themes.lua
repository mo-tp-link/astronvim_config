return {
  {
    "everviolet/nvim",
    name = "evergarden",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      theme = {
        variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
        accent = "green",
      },
      editor = {
        transparent_background = false,
        sign = { color = "none" },
        float = {
          color = "mantle",
          invert_border = false,
        },
        completion = {
          color = "surface0",
        },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    config = function()
      -- Default options:
      require("kanagawa").setup {
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = false, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave", -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      }
    end,
  },

  {
    "Yazeed1s/oh-lucy.nvim",
    name = "lucy",
    priority = 1000,
  },
  -- {
  --   "sam4llis/nvim-tundra",
  --   name = "tundra",
  --   priority = 1000,
  --   opts = {},
  -- },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = false,
    priority = 1000,
  },
  {
    "AlexvZyl/nordic.nvim",
    name = "nordic",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup {
        -- This callback can be used to override the colors used in the base palette.
        -- on_palette = function(palette) end,
        -- This callback can be used to override the colors used in the extended palette.
        -- after_palette = function(palette) end,
        -- This callback can be used to override highlights before they are applied.
        -- on_highlight = function(highlights, palette) end,
        -- Enable bold keywords.
        bold_keywords = true,
        -- Enable italic comments.
        italic_comments = true,
        -- Enable editor background transparency.
        transparent = {
          -- Enable transparent background.
          bg = false,
          -- Enable transparent background for floating windows.
          float = true,
        },
        -- Enable brighter float border.
        bright_border = false,
        -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        reduced_blue = true,
        -- Swap the dark background with the normal one.
        swap_backgrounds = true,
        -- Cursorline options.  Also includes visual/selection.
        cursorline = {
          -- Bold font in cursorline.
          bold = true,
          -- Bold cursorline number.
          bold_number = false,
          -- Available styles: 'dark', 'light'.
          theme = "light",
          -- Blending the cursorline bg with the buffer bg.
          blend = 0.85,
        },
        -- noice = {
        --   -- Available styles: `classic`, `flat`.
        --   style = "classic",
        -- },
        -- telescope = {
        --   -- Available styles: `classic`, `flat`.
        --   style = "flat",
        -- },
        -- leap = {
        --   -- Dims the backdrop when using leap.
        --   dim_backdrop = false,
        -- },
        ts_context = {
          -- Enables dark background for treesitter-context window
          dark_background = true,
        },
      }
    end,
  },
}
