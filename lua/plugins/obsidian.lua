return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "echasnovski/mini.pick", config = function() require("mini.pick").setup() end },
  },
  keys = {
    { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Obsidian Search" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Obsidian Backlinks" },
    { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Obsidian Insert Template" },
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Obsidian New Note" },
    { "<leader>oc", "<cmd>ObsidianToggleCheckbox<CR>", desc = "Obsidian Toggle Checkbox" },
    { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Obsidian Links" },
    { "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Obsidian Rename" },
    { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Obsidian Open in App" },
    { "<leader>og", "<cmd>ObsidianTags<CR>", desc = "Obsidian Tags" },
    { "<leader>oi", "<cmd>ObsidianTOC<CR>", desc = "Obsidian TOC (Index)" },
    { "<leader>ol", "<cmd>ObsidianLink<CR>", desc = "Obsidian Link Selection", mode = "v" },
    { "<leader>on", "<cmd>ObsidianLinkNew<CR>", desc = "Obsidian Link New Note", mode = "v" },
    { "<leader>oe", "<cmd>ObsidianExtractNote<CR>", desc = "Obsidian Extract Note", mode = "v" },
  },
  opts = {
    workspaces = {
      {
        name = "obsidian",
        path = "/mnt/c/Users/Mo/OneDrive - TP-Link/Obsidian",
      },
    },
    -- only insert frontmatter if the file doesn't already have it
    disable_frontmatter = function()
      local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
      return first_line == "---"
    end,
    picker = {
      name = "mini.pick",
    },
    templates = {
      folder = "templates",
    },
    follow_url_func = function(url) vim.fn.jobstart { "xdg-open", url } end,
    mappings = {
      ["gf"] = {
        action = function() return require("obsidian").util.gf_passthrough() end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<CR>"] = {
        action = function() return require("obsidian").util.smart_action() end,
        opts = { buffer = true, expr = true },
      },
    },
    ui = {
      enable = false,
    },
  },
}
