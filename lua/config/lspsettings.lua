---@diagnostic disable: missing-fields
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Pressing 'K' once opens the window; pressing it again jumps into the window
    vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 20 })
      end,
      { desc = 'LSP hover documentation' })
    vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>Lspsaga goto_type_definition<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs',
      function()
        vim.lsp.buf.signature_help({ border = "double", max_width = 80, max_height = 20 })
      end,
      { desc = 'LSP signature help' })
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set('n', '<F4>', '<cmd>Lspsaga code_action<cr>', opts)

    vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', opts)
    vim.keymap.set('n', 'gL', '<cmd>Lspsaga show_buf_diagnostics<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end
})

local default_setup = function(server)
  vim.lsp.config[server] = {
    capabilities = lsp_capabilities,
  }
end

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = { default_setup },
})

local cmp = require('cmp')

cmp.setup({
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None,CursorLine:PmenuSel",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    },
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      local luasnip = require("luasnip")
      if not luasnip then
        return
      end
      luasnip.lsp_expand(args.body)
    end,
  },
})

vim.lsp.config['html'] = {
  filetypes = { 'html', 'htmldjango', 'jinja', 'javascriptreact', 'typescriptreact' },
}

vim.lsp.config('tailwindcss', {
  init_options = {
    userLanguages = {
      htmldjango = "html",
      jinja = "html",
      eelixir = 'html-eex',
      eruby = 'erb',
    },
  },
})

vim.lsp.config['denols'] = {
  cmd = { 'deno', 'lsp' },
  root_markers = { 'deno.json', 'deno.jsonc' },
}

vim.lsp.config['tsserver'] = {
  root_markers = { 'package.json', 'tsconfig.json' },
  workspace_required = true,
}

vim.lsp.config['djlsp'] = {
  root_markers = { 'manage.py' },
}

vim.lsp.config['rust_analyzer'] = {
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
      check = { command = 'clippy' },
      lens = {
        debug = {
          enable = true
        },
        enable = true,
        implementations = {
          enable = true
        },
        references = {
          adt = {
            enable = true
          },
          enumVariant = {
            enable = true
          },
          method = {
            enable = true
          },
          trait = {
            enable = true
          }
        },
        run = {
          enable = true
        },
        updateTest = {
          enable = true
        }
      }
    },
  },
}
