local opt = vim.opt

-- UI / Visual Feedback
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false
opt.showcmd = true -- default
opt.cmdheight = 1 -- default
opt.laststatus = 3
opt.colorcolumn = "120"
opt.wrap = true
opt.linebreak = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Editing Behavior
opt.mouse = ""
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undo"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 250
opt.timeoutlen = 300

-- Formatting
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = false
opt.grepprg = "rg --vimgrep"

-- Splits/Windows
opt.splitright = true
opt.splitbelow = true
opt.equalalways = false

--Completion/LSP
opt.completeopt = { "menu", "menuone", "noinsert" }
opt.pumheight = 10
opt.shortmess:append("c")

-- Folding (Treesitter based)
opt.foldmethod = "expr"
opt.foldexpr = "nvm_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevel = 99

-- Performance
opt.lazyredraw = true
opt.ttyfast = true

-- Misc
opt.fileformat = "unix"
opt.hidden = true
opt.errorbells = false
opt.visualbell = true
opt.confirm = true
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- ============================================================================
-- DIAGNOSTICS
-- ============================================================================

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = {
    prefix = "💥",
    spacing = 4,
  },
  signs = {
    text = {
      [severity.ERROR] = "🧨",
      [severity.WARN] = "⚠️",
      [severity.HINT] = "📎",
      [severity.INFO] = "📫",
    }
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  }
})
