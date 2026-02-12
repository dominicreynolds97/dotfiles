local harpoon = require("harpoon")

harpoon:setup()

-- ===================================================================================
-- KEYMAPPING
-- ===================================================================================

local keymap = vim.keymap.set

local options = function(description)
  return {
    noremap = true,
    silent = true,
    desc = description,
  }
end

keymap("n", "<leader>ha", function() harpoon:list():add() end, options("Harpoon: add"))
keymap("n", "<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, options("Harpoon: open menu"))

keymap("n", "<leader>hn", function() harpoon:list():next() end, options("Harpoon: next"))
keymap("n", "<leader>hp", function() harpoon:list():prev() end, options("Harpoon: prev"))

