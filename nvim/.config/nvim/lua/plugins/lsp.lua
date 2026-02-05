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
          keymap("n", "<leader>h", vim.lsp.buf.hover, opts_with_desc("Hover documentation"))

          -- Signature help
          keymap("n", "<leader>sh", vim.lsp.buf.signature_help, opts_with_desc("Signature Help"))

          -- Rename symbol
          keymap("n", "<leader>rn", vim.lsp.buf.rename, opts_with_desc("Rename symbol"))

          -- Code actions
          keymap({ "n", "i" }, "<leader>ca", vim.lsp.buf.code_action, opts_with_desc("Code actions"))

          -- Format buffer
          keymap("n", "<leader>fb", function()
            vim.lsp.buf.format({ async = true })
          end, opts_with_desc("Format buffer"))

          -- Show line diagnostics
          keymap("n", "<leader>ds", vim.diagnostic.open_float, opts_with_desc("Show line diagnostics"))

          -- Go to next/previous diagnostic
          keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts_with_desc("Next diagnostic"))
          keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts_with_desc("Prev diagnostic"))

          -- Type definition
          keymap("n", "<leader>td", vim.lsp.buf.type_definition, opts_with_desc("Type definition"))
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
