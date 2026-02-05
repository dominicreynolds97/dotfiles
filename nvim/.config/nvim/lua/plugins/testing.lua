return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rcasia/neotest-java",
    },
    keys = {
      -- Lazy load on first test key
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-java")({
            ignore_wrapper = false,
          }),
        },

        icons = {
          passed = "✓",
          running = "●",
          failed = "✗",
          skipped = "○",
          unknown = "?",
        },

        output = {
          enabled = true,
          open_on_run = true,
        },

        summary = {
          enabled = true,
          expand_errors = true,
        },

        -- Keybindings to map:
        -- - Run nearest test
        -- - Run current file tests
        -- - Run previous tests
        -- - Run all tests
        -- - Debug nearest test
        -- - Stop test
        -- - Toggle test summary
        -- - Show test output
        -- - Jump to next/previous failed test
      })
    end,
  }
}
