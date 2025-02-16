-- setting global mapleader
vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- bootstrap lazy.nvim, and your plugins
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.lspsettings")
require("config.autocmds")
require("config.noicesettings")
require("config.notify-settings")
require("config.telescope")

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

-- Uncomment the next line to set the autocompletion of Codeium AI as default
-- vim.g.codeium_manual = true

-- To enable automatic triggering of codeium anytime run the command below
-- let g:codeium_manual = v:false

-- To disable automatic triggering of codeium anytime run the command below
-- let g:codeium_manual = v:true
