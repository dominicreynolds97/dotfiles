return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      -- Lazy load on first debug key
      -- Define your debug keybindings here
    },
    config = function()
      local dap = require("dap")

      -- Java debug config
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
        {
          type = "java",
          request = "launch",
          name = "Debug (Launch) - Current File",
          mainClass = "${file}"
        },
      }

      vim.fn.sign_define("DapBreakpoint", {
        text = "●", texthl = "DapBreakpoint",
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = "◆", texthl = "DapBreakpoint",
      })

      vim.fn.sign_define("DapStopped", {
        text = "→", texthl = "DapStopped",
      })

      -- =============================================================================================================
      -- KEYMAPPING
      -- =============================================================================================================

      local keymap = vim.keymap.set

      -- Continue/Start debugging
      keymap("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })

      -- Step over
      keymap("n", "<leader>dso", dap.step_over, { desc = "Debug: Step over" })

      -- Step into
      keymap("n", "<leader>dsi", dap.step_into, { desc = "Debug: Step into" })

      -- Step out
      keymap("n", "<leader>dst", dap.step_out, { desc = "Debug: Step out" })

      -- Toggle breakpoint
      keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })

      -- Set conditional breakpoint
      keymap("n", "<leader>dc", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Conditional breakpoint" })

      -- Clear all breakpoints
      keymap("n", "<leader>dx", dap.clear_breakpoints, { desc = "Debug: Clear breakpoints" })

      -- Toggle DAP UI
      keymap("n", "<leader>du", require("dapui").toggle, { desc = "Debug: Toggle UI" })

      -- Open REPL
      keymap("n", "<leader>do", dap.repl.open, { desc = "Debug: Open REPL" })

      -- Run last debug configuration
      keymap("n", "<leader>drl", dap.run_last, { desc = "Debug: Run last" })

      -- Terminate debug session
      keymap("n", "<leader>dk", dap.terminate, { desc = "Debug: Terminate" })

      -- Restart debug session
      keymap("n", "<leader>drs", dap.restart, { desc = "Debug: Restart" })

    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    depdendencies = { "nvim-dap", "nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup({
        commented = true
      })
    end,
  },
}
