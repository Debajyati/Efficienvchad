---@diagnostic disable: missing-fields
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>Lspsaga goto_type_definition<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
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
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = "supermaven" },
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
