local keymap = vim.keymap.set

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "jdtls",
          "lua_ls",
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      --local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.lua_ls.setup({
        --capabilities = capabilites,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          }
        }
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr }
          local opts_with_desc = function(description)
            return {
              buffer = bufnr,
              desc = description,
            }
          end

          -- Go to definition
          keymap("n", "gd", vim.lsp.buf.definition, opts_with_desc("Go to definition"))

          -- Go to declaration
          keymap("n", "gs", vim.lsp.buf.declaration, opts_with_desc("Go to declaration"))

          -- Go to implementation
          keymap("n", "gi", vim.lsp.buf.implementation, opts_with_desc("Go to implementation"))

          -- Find references
          keymap("n", "gr", vim.lsp.buf.references, opts_with_desc("Find references"))

          -- Hover documentation
          keymap("n", "<leader>d", vim.lsp.buf.hover, opts_with_desc("Hover documentation"))

          -- Signature help
          -- Rename symbol
          -- Code actions
          -- Format buffer
          -- Show line diagnostics
          -- Go to next/previous diagnostic
        end,
      })
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java"
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      -- TODO - Map keys
    end,
  },
}
