local function set_markdown_highlights()
  vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#F65454" }) -- Using baby_pink
  vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#13FBA7" }) -- Using green
  vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#76CEFF" }) -- Using blue
  vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#FFEB81" }) -- Using yellow
  vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#E777FA" }) -- Using pink/purple
  vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#FB9D46" }) -- Using orange

  vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#F65454", bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#13FBA7", bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = "#76CEFF", bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = "#FFEB81", bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = "#E777FA", bold = true })
  vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = "#FB9D46", bold = true })
  -- Remove background highlight completely
--   vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "NONE" })
--   vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "NONE" })
--   vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "NONE" })
--   vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "NONE" })
--   vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "NONE" })
--   vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "NONE" })
--   -- Font
  vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#F4AFD2", bg = "None", italic = true })
  vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#F9215D", bg = "None", italic = true })
end
--
set_markdown_highlights()

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ft = { "markdown", "qmd", "quarto" },
  opts = {
    render_modes = true,
    heading = {
      enabled = true,
      render_modes = false,
      atx = true,
      setext = true,
      sign = true,
      -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      icons = {},
      position = "inline",
      signs = { "󰫎 " },
      width = "full",
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = false,
      border_virtual = false,
      border_prefix = false,
      above = "▄",
      below = "▀",
      backgrounds = {
        -- "RenderMarkdownH1Bg",
        -- "RenderMarkdownH2Bg",
        -- "RenderMarkdownH3Bg",
        -- "RenderMarkdownH4Bg",
        -- "RenderMarkdownH5Bg",
        -- "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
      custom = {},
    },

    checkbox = {
      unchecked = { icon = " ", highlight = "RenderMarkdownH1" },
      checked = { icon = " ", highlight = "RenderMarkdownH2" },
      custom = {
        followup = { raw = "[~]", rendered = "󰓎 ", highlight = "RenderMarkdownH6" },
        important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownH4" }, -- Exclamation mark icon
        pending = { raw = "[>]", rendered = "󰦕 ", highlight = "RenderMarkdownH3" },
        question = { raw = "[?]", rendered = "󰋗",  highlight = "RenderMarkdownH2" },
      },
    },
  },
}
