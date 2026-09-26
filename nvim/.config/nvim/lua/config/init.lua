-- config/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.options")
require("config.autocmds")
require("config.lazy")
require("config.keymap")

if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --noheading --smart-case"
  vim.opt.grepformat = "%f:%1:%c:%m,%f:%1:%m"
end

