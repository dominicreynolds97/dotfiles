return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local opts = { buffer = bufnr }

          -- ================================================================================================
          -- KEYMAPPING
          -- ================================================================================================
          keymap = vim.keymap.set

          -- Next hunk
          keymap("n", "<leader>gnh", function()
            if vim.wo.diff then return "<leader>gn" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Git: Next hunk" })

          -- Prev hunk
          keymap("n", "<leader>gph", function()
            if vim.wo.diff then return "<leader>gph" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Git: Prev hunk" })

          -- Stage hunk
          keymap("n", "<leader>gsh", gs.stage_hunk, { desc = "Git: Stage hunk" })

          -- Stage buffer
          keymap("n", "<leader>gsb", gs.stage_buffer, { desc = "Git: Stage buffer" })

          -- Undo stage hunk
          keymap("n", "<leader>guh", gs.undo_stage_hunk, { desc = "Git: Undo stage hunk" })

          -- Reset hunk
          keymap("n", "<leader>grh", gs.reset_hunk, { desc = "Git: Reset hunk" })

          -- Reset buffer
          keymap("n", "<leader>grb", gs.reset_buffer, { desc = "Git: Reset buffer" })

          -- Preview hunk
          keymap("n", "<leader>gph", gs.preview_hunk, { desc = "Git: Preview hunk" })

          -- Blame line
          keymap("n", "<leader>gbl", function()
            gs.blame_line({ full = true })
          end, { desc = "Git: Blame line" })

          -- Toggle blame
          keymap("n", "<leader>gbt", gs.toggle_current_line_blame, { desc = "Git: Toggle blame" })

          -- Diff this file
          keymap("n", "<leader>gdt", gs.diffthis, { desc = "Git: Diff this file" })

          -- Diff with HEAD
          keymap("n", "<leader>gdh", function()
            gs.diffthis("~")
          end, { desc = "Git: Diff HEAD" })

          -- Stage hunk (visual mode)
          keymap("v", "<leader>gsh", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Git: Stage hunk" })

          -- Reset hunk (visual mode)
          keymap("v", "<leader>grh", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Git: Reset hunk" })
        end,
      })
    end,
  },
}
