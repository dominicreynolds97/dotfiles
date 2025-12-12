local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(_client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


--local java = require('java')
--java.setup({})
--vim.keymap.set('n', '<leader>jr', java.runner.built_in.run_app)

require('neoconf').setup({})

--require('lspconfig').rust_analyzer.setup {
--  settings = {
--    ["rust-analyzer"] = {
--      procMacro = {
--        ignored = {
--          leptos_macro = {
--            "server"
--          }
--        }
--      }
--    }
--  }
--}
--
--require('lspconfig').jdtls.setup({
--  settings = {
--    java = {
--      configuration = {
--        runtimes = {
--          name = "JavaSE-21",
--          path = vim.fn.expand('~/Development/jdks/jdk-21.0.1'),
--          default = true
--        }
--      }
--    }
--  }
--})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'cssls',
    'dockerls',
    'html',
    'eslint',
    'lua_ls',
    'jsonls',
    'jdtls',
    'lemminx',
    'yamlls',
    'sqlls',
    'clangd'
  },
  automatic_installation = true,
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      local lsp = require('lspconfig')
      lsp.lua_ls.setup(lua_opts)
      lsp.sqlls.setup{
        filetypes= { 'sql' },
        root_dir = function(_)
          return vim.loop.cwd()
        end,
      }
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

