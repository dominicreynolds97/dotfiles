local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ============================================================================
-- GENERAL
-- ============================================================================

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", { clear = true }),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = augroup("ResizeSplits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close certain filetypes with 'q'
autocmd("FileType", {
  group = augroup("CloseWithQ", { clear = true }),
  pattern = { "qf", "help", "man", "lspinfo", "checkhealth" },
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true })
  end,
})

-- ============================================================================
-- LSP-SPECIFIC
-- ============================================================================

-- Format on save
-- autocmd("BufWritePre", {
--   group = augroup("FormatOnSave", { clear = true }),
--   pattern = "*.java",
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })

-- Show line diagnostics on hover
autocmd("CursorHold", {
  group = augroup("ShowDiagnostics", { clear = true }),
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
      border = "rounded",
      source = "always",
      prefix = " ",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- ============================================================================
-- JAVA-SPECIFIC
-- ============================================================================

-- Set Java-specific options
autocmd("FileType", {
  group = augroup("JavaSettings", { clear = true }),
  pattern = "java",
  callback = function()
    vim.opt_local.colorcolumn = "120"
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- ============================================================================
-- UI IMPROVEMENTS
-- ============================================================================

-- Don't auto-comment new lines
autocmd("BufEnter", {
  group = augroup("DisableAutoComment", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
