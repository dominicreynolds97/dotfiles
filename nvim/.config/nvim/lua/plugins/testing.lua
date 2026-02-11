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
      { "<leader>trn", function() require("neotest").run.run() end, desc = "Test: Run nearest" },
      { "<leader>trf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run file" },
      { "<leader>tra", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Test: Run all" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: Debug nearest" },
      { "<leader>tx", function() require("neotest").run.stop() end, desc = "Test: Stop" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: Toggle summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: Show output" },
      { "<leader>tnf", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Test: Next failed" },
      { "<leader>tpf", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Test: Prev failed" },
    },
    config = function()
      print("setting up neotest")
      require("neotest").setup({
        adapters = {
          require("neotest-java")({
            ignore_wrapper = false,
          }),
        },

        icons = {
          passed = "🍾",
          running = "⌛️",
          failed = "😭",
          skipped = "🧑‍🦯‍➡️",
          unknown = "🤷‍♀️",
        },

        output = {
          enabled = true,
          open_on_run = true,
        },

        summary = {
          enabled = true,
          expand_errors = true,
        },

      })

      -- ==============================================================================================================
      -- KEYMAPPING
      -- ==============================================================================================================
--      local neotest = require("neotest")
--      local keymap = vim.keymap.set
--
--      -- Run nearest test
--      keymap("n", "<leader>trn", function()
--        neotest.run.run()
--      end, { desc = "Test: Run nearest" })
--
--      -- Run current file tests
--      keymap("n", "<leader>trf", function()
--        neotest.run.run(vim.fn.expand("%"))
--      end, { desc = "Test: Run file" })
--
--      -- Run all tests
--      keymap("n", "<leader>tra", function()
--        neotest.run.run(vim.fn.getcwd())
--      end, { desc = "Test: Run all" })
--
--      -- Debug nearest test
--      keymap("n", "<leader>td", function()
--        neotest.run.run({ strategy = "dap" })
--      end, { desc = "Test: debug nearest" })
--
--      -- Stop test
--      keymap("n", "<leader>tx", neotest.run.stop, { desc = "Test: Stop" })
--
--      -- Toggle test summary
--      keymap("n", "<leader>ts", neotest.summary.toggle, { desc = "Test: Toggle summary" })
--
--      -- Show test output
--      keymap("n", "<leader>to", function()
--        neotest.output.open({ enter = true })
--      end, { desc = "Test: Show output" })
--
--      -- Jump to next/previous failed test
--      keymap("n", "<leader>tnf", function()
--        neotest.jump.next({ status = "failed" })
--      end, { desc = "Test: Next failed" })
--
--      keymap("n", "<leader>tpf", function()
--        neotest.jump.prev({ status = "failed" })
--      end, { desc = "Test: Prev failed" })
    end,
  }
}
