-- setting global mapleader
vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- bootstrap lazy.nvim, and your plugins
require("config.options")
require("config.lazy")
require("config.lspsettings")
require("config.autocmds")
require("config.noicesettings")
require("config.notify-settings")
require("config.telescope")
require("config.nvim-tree")
require("config.treesitter")
require("config.commands")
require("config.keymaps")

-- setting colorscheme as default
vim.cmd [[colorscheme darkplus]]

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

vim.g.skip_builtin_treesitter_highlight = 1

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- Enable spell checking for markdown files
-- vim.cmd [[
--  autocmd FileType markdown setlocal spell
--  ]]
--  Enable spell checking for text files
--  vim.cmd [[
--  autocmd FileType text setlocal spell
--  ]]
--  Enable spell checking for git commit messages
--  vim.cmd [[
--  autocmd FileType gitcommit setlocal spell
--  ]]
--  Enable spell checking for LaTeX files
--  vim.cmd [[
--  autocmd FileType tex setlocal spell
--  ]]
-- Set transparency level (0-100)
-- vim.cmd [[
-- let g:transparency = 20
--  ]]
--  Apply transparency to Neovim
vim.cmd [[
 autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
 autocmd VimEnter * hi NormalNC guibg=NONE ctermbg=NONE
 autocmd VimEnter * hi VertSplit guibg=NONE ctermbg=NONE
 autocmd VimEnter * hi StatusLine guibg=NONE ctermbg=NONE
 autocmd VimEnter * hi LineNr guibg=NONE ctermbg=NONE
 autocmd VimEnter * hi NonText guibg=NONE ctermbg=NONE
 ]]
