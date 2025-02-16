local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = 'luasnip' },
    { name = 'look' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  completions = {
    autocomplete = true,
  }
})


