return {
  "hkupty/iron.nvim",
  keys = { { "<Leader>iI", "<cmd>IronRepl<cr>", desc = "Iron" } },
  config = function()
    local iron = require "iron.core"
    local view = require "iron.view"
    local python_format = require("iron.fts.common").bracketed_paste_python
    iron.setup {
      config = {
        scratch_repl = false,
        buflisted = true,
        close_on_exit = true,
        focus_on_send = false,
        repl_auto_scroll = true,
        repl_open_cmd = view.split.vertical.botright("50%", {
          winfixwidth = false,
          winfixheight = false,
        }),

        -- your repl definitions come here
        repl_definition = {
          sh = {
            -- can be a table or a function that
            -- returns a table (see below)
            command = { "zsh" },
          },
          -- haskell = {
          --   command = function(meta)
          --     local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
          --     return { "cabal", "v2-repl", filename }
          --   end,
          -- },
          python = {
            command = {
              "ipython",
              "--no-autoindent",
            },
            format = python_format,
            block_dividers = { "# %%", "#%%" },
          },
          -- python = {
          --   command = { "jupyter-console" },
          --   format = require("iron.fts.common").bracketed_paste,
          --   block_deviders = { "# %%", "#%%" },
          -- },
          quarto = {
            command = { "ipython", "--no-autoindent" },
            format = python_format,
            block_dividers = { "# %%", "#%%" },
          },
        },
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {

        restart_repl = "<leader>iR", -- calls `IronRestart` to restart the repl
        toggle_repl = "<leader>ii",
        send_motion = "<leader>is",
        visual_send = "<leader>is",
        send_file = "<leader>if",
        send_line = "<leader>il",
        send_mark = "<leader>in",
        mark_motion = "<leader>im",
        mark_visual = "<leader>im",
        remove_mark = "<leader>iu",
        cr = "<leader>i<cr>",
        interrupt = "<leader>ix",
        exit = "<leader>iq",
        clear = "<leader>ic",
        send_code_block = "<leader>ib",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = false,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }
  end,
}
