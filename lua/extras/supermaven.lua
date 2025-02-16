local spec = {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-x>",
        accept_word = "<C-j>",
      },
    })
    vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", {fg ="#6CC644"})
  end
}

return spec
