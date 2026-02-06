local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>x", vim.cmd.Ex)

-- ============================================================================
-- SEARCH & REPLACE
-- ============================================================================

-- Search and replace in file
keymap("n", "<leader>sr", ":%s/", { desc = "Search and replace whole file" })

-- Search and replace visual selection
keymap("v", "<leader>sr", ":s/", { desc = "Search and replace selection" })

-- Search and replace current line
keymap("n", "<leader>sl", ":s/", { desc = "Search and replace current line" })


-- ============================================================================
-- TELESCOPE (FUZZY FINDER)
-- ============================================================================
local telescope_builtin = require("telescope.builtin")

-- Find files
keymap("n", "<leader>pf", telescope_builtin.find_files, { desc = "Find files" })

-- Live grep
keymap("n", "<leader>ps", telescope_builtin.live_grep, { desc = "Live grep" })

-- Buffers
keymap("n", "<leader>pb", telescope_builtin.buffers, { desc = "Find buffers" })

-- Recenp files
keymap("n", "<leader>pr", telescope_builtin.oldfiles, { desc = "Recent files"})

-- Gip files
keymap("n", "<leader>pg", telescope_builtin.git_files, { desc = "Git files" })

-- Gip commits
keymap("n", "<leader>pc", telescope_builtin.git_commits, { desc = "Git commits" })

-- Grep spring under cursor
keymap("n", "<leader>pw", telescope_builtin.grep_string, { desc = "Grep current word" })

-- LSP documenp symbols
keymap("n", "<leader>pld", telescope_builtin.lsp_document_symbols, { desc = "Document symbols" })

-- LSP workspace symbols
keymap("n", "<leader>plw", telescope_builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })

-- Diagnospics
keymap("n", "<leader>pd", telescope_builtin.diagnostics, { desc = "Diagnostics" })

-- Command hispory
keymap("n", "<leader>phc", telescope_builtin.command_history, { desc = "Command history" })

-- Search hispory
keymap("n", "<leader>phs", telescope_builtin.search_history, { desc = "Search history" })

-- Keymaps
keymap("n", "<leader>pk", telescope_builtin.keymaps, { desc = "Keymaps" })
