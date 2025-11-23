-- Options are automatically loaded before lazy.nvim startup
-- Add any additional options here

vim.opt.background = "dark"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.wrap = false

vim.opt.undofile = true


vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.cmd("filetype plugin indent on")
vim.opt.spelllang = 'en_us'

-- For people using clipboard managers like xclip, wl-clipboard, etc. in WSL
-- to sync clipboard between Windows and WSL Neovim.
-- Uncomment the 2nd line below where xclip is used as default. If you use any other
-- clipboard manager, then you have change the lines accordingly.
-- With these lines you can efficiently copy texts selected in
-- VISUAL mode to clipboard with Ctrl+C & you won't need registers.

vim.opt.clipboard:append("unnamedplus")
-- vim.api.nvim_set_keymap("v", "<C-c>", ":w !xclip -i -sel c<CR><CR>", { noremap = true })

-- Builtin Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
  },
  severity_sort = true,
})
