local g = vim.g
local o = vim.o

-- Editor UI
o.number = true
o.rnu = true
o.numberwidth = 4

o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true

o.undodir = os.getenv('HOME' .. '/.vim/undodir')
o.undofile = true

o.hlsearch = false
o.incsearch = true

o.scrolloff = 8
o.updatetime = 50

-- Disable Mouse
vim.opt.mouse = ""

