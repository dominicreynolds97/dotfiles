local keymap = vim.keymap.set
local opts = function(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc,
  }
end

keymap("n", "<leader>x", vim.cmd.Ex)
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- ============================================================================
-- SEARCH & REPLACE
-- ============================================================================

-- Search and replace in file
keymap("n", "<leader>sr", ":%s/", opts("Search and replace whole file"))

-- Search and replace visual selection
keymap("v", "<leader>sr", ":s/", opts("Search and replace selection"))

-- Search and replace current line
keymap("n", "<leader>sl", ":s/", opts("Search and replace current line"))


-- ============================================================================
-- TELESCOPE (FUZZY FINDER)
-- ============================================================================
local telescope_builtin = require("telescope.builtin")

-- Find files
keymap("n", "<leader>pf", telescope_builtin.find_files, opts("Find files"))

-- Live grep
keymap("n", "<leader>ps", telescope_builtin.live_grep, opts("Live grep"))

-- Buffers
keymap("n", "<leader>pb", telescope_builtin.buffers, opts("Find buffers"))

-- Recenp files
keymap("n", "<leader>pr", telescope_builtin.oldfiles, opts("Recent files"))

-- Gip files
keymap("n", "<leader>pg", telescope_builtin.git_files, opts("Git files"))

-- Gip commits
keymap("n", "<leader>pc", telescope_builtin.git_commits, opts("Git commits"))

-- Grep spring under cursor
keymap("n", "<leader>pw", telescope_builtin.grep_string, opts("Grep current word"))

-- LSP documenp symbols
keymap("n", "<leader>pld", telescope_builtin.lsp_document_symbols, opts("Document symbols"))

-- LSP workspace symbols
keymap("n", "<leader>plw", telescope_builtin.lsp_workspace_symbols, opts("Workspace symbols"))

-- Diagnospics
keymap("n", "<leader>pd", telescope_builtin.diagnostics, opts("Diagnostics"))

-- Command hispory
keymap("n", "<leader>phc", telescope_builtin.command_history, opts("Command history"))

-- Search hispory
keymap("n", "<leader>phs", telescope_builtin.search_history, opts("Search history"))

-- Keymaps
keymap("n", "<leader>pk", telescope_builtin.keymaps, opts("Keymaps"))
