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
keymap("n", "<leader>tf", telescope_builtin.find_files, { desc = "Find files" })

-- Live grep
keymap("n", "<leader>ts", telescope_builtin.live_grep, { desc = "Live grep" })

-- Buffers
keymap("n", "<leader>tb", telescope_builtin.buffers, { desc = "Find buffers" })

-- Recent files
keymap("n", "<leader>tr", telescope_builtin.oldfiles, { desc = "Recent files"})

-- Git files
keymap("n", "<leader>tg", telescope_builtin.git_files, { desc = "Git files" })

-- Git commits
keymap("n", "<leader>tc", telescope_builtin.git_commits, { desc = "Git commits" })

-- Grep string under cursor
keymap("n", "<leader>tw", telescope_builtin.grep_string, { desc = "Grep current word" })

-- LSP document symbols
keymap("n", "<leader>tld", telescope_builtin.lsp_document_symbols, { desc = "Document symbols" })

-- LSP workspace symbols
keymap("n", "<leader>tlw", telescope_builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })

-- Diagnostics
keymap("n", "<leader>td", telescope_builtin.diagnostics, { desc = "Diagnostics" })

-- Command history
keymap("n", "<leader>thc", telescope_builtin.command_history, { desc = "Command history" })

-- Search history
keymap("n", "<leader>ths", telescope_builtin.search_history, { desc = "Search history" })

-- Keymaps
keymap("n", "<leader>tk", telescope_builtin.keymaps, { desc = "Keymaps" })
