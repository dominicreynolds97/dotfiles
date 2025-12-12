vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Explore)

-- VISUAL - move selection up/down a line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- save
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- C-d/u and center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- paste and keep old yanked value
vim.keymap.set("x", "<leader>p", "\"_dP")

-- new line in normal mode
vim.keymap.set("n", "<leader>l", "o<Esc>")

-- format whole file
vim.keymap.set("n", "<leader>f", "mtgg=G`t")

-- yank from system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"_Y")

-- FOR LEARNING
-- Disable Arrow Keys
vim.keymap.set({"n", "v", "i"}, "<up>", "<nop>")
vim.keymap.set({"n", "v", "i"}, "<down>", "<nop>")
vim.keymap.set({"n", "v", "i"}, "<left>", "<nop>")
vim.keymap.set({"n", "v", "i"}, "<right>", "<nop>")

-- Comment lines
vim.keymap.set({"n", "v"}, "<leader>/", "<C-v>0i//<esc>")
vim.keymap.set({"n", "v"}, "<leader>-", "<C-v>0I--<Esc>")
-- Uncomment lines
vim.keymap.set({"n", "v"}, "<leader>?", ":s/\\/\\//<CR>")
vim.keymap.set({"n", "v"}, "<leader>_", ":s/--//<CR>")

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>e',  vim.diagnostic.setloclist)

-- ChangeList
vim.keymap.set('n', '<leader>co', ":copen<CR>")
vim.keymap.set('n', '<leader>cc', ":cclose<CR>")
vim.keymap.set('n', '<leader>cn', ":cnext<CR>zz")
vim.keymap.set('n', '<leader>cp', ":cprev<CR>zz")

-- DiffView
vim.keymap.set('n', '<leader>do', ':DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>')
