local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

end)

local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({select = false}),
    ['<C-a>'] = cmp.mapping.abort(),
    ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {
	  'tsserver',
	  'rust_analyzer',
	  'lua_ls',
	  'eslint',
	  'python-lsp-server'
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

--Setting vim as global variable
require'lspconfig'.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
        },
    },
}
)
