-- options
local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.clipboard = "unnamedplus"
o.foldlevel = 99

-- autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "org", "norg" },
  callback = function()
    local current_file = vim.fn.expand "%:p"
    if current_file:match "/Notes/" then
      -- change conceallevel to 1 in md files for obsidian only
      vim.opt_local.conceallevel = 1
    end
    if current_file:match "/notes/" then vim.opt_local.conceallevel = 2 end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "md" },
  callback = function()
    -- enable spell check for md files
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- clipbaord
vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
vim.opt.clipboard:append "unnamedplus"
