return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },

          -- TODO MAPPINGS
          mappings = {
            i = {

            },
            n = {

            },
          },

          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },

          sorting_strategy = "ascending",

          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "target/",
            "build/",
            "%.class",
          },
        },

        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          }
        }
      })

      telescope.load_extension("fzf")
    end,
  }
}
