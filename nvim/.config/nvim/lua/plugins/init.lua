require("lazy").setup({
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.dap" },
  { import = "plugins.testing" },
  { import = "plugins.navigation" },
  { import = "plugins.ui" },
  { import = "plugins.git" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "java",
          "lua",
          "vim",
          "node",
          "markdown",
          "json",
          "jaml",
          "xml",
        },
        autoinstall = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          -- Mappings here
        }
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        -- So I don't forget my own mappings
      })
    end,
  }
})


