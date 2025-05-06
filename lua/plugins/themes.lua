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
    "Yazeed1s/oh-lucy.nvim",
    name = "lucy",
    priority = 1000,
  },
  {
    "sam4llis/nvim-tundra",
    priority = 1000,
    ops = {},
  },
}
