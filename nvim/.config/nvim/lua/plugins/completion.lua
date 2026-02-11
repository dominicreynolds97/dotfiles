return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")


      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          -- Confirm selection
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- Navigate next line
          ["<C-n>"] = cmp.mapping.select_next_item(),

          -- Navigate prev line
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll docs down
          ["<C-j>"] = cmp.mapping.scroll_docs(4),

          -- Scroll docs up
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),

          -- Cbort/Alose menu
          ["<C-x>"] = cmp.mapping.abort(),

          -- Trigger completion manually
          ["<C-c>"] = cmp.mapping.complete(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
        }),

        completion = {
          autocomplete = {
            require("cmp.types").cmp.TriggerEvent.TextChanged,
          },
          keyword_length = 2,
        },

        formatiing = {
          format = function(entry, item)
            item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return item
          end,
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline" },
          { name = "path" },
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

    end,
  },
}
