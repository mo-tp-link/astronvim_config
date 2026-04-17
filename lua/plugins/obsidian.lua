return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    frontmatter  = {enabled = false},
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "work",
        path = "/mnt/c/Users/Mo/OneDrive - TP-Link/Obsidian",
      },
    },
  },
  -- Optional, customize how note IDs are generated given an optional title.
  -- ---@param title string|?
  -- ---@return string
  -- note_id_func = function(title)
  --   -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
  --   -- In this case a note with the title 'My new note' will be given an ID that looks
  --   -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
  --   local suffix = ""
  --   if title ~= nil then
  --     -- If title is given, transform it into valid file name.
  --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  --   else
  --     -- If title is nil, just add 4 random uppercase letters to the suffix.
  --     for _ = 1, 4 do
  --       suffix = suffix .. string.char(math.random(65, 90))
  --     end
  --   end
  --   return tostring(os.time()) .. "-" .. suffix
  -- end,
}
