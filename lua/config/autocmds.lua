-- Add any additional autocmds here


-- Show neotree on startup
-- vim.api.nvim_create_augroup("neotree", {})
-- vim.api.nvim_create_autocmd("UiEnter", {
  -- desc = "Open Neotree automatically",
  -- group = "neotree",
  -- callback = function()
    -- if vim.fn.argc() == 0 then
      -- vim.cmd [[Neotree toggle]]
    -- end
  -- end,
-- })

-- Highlight on yank
vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = "highlight_yank",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})
-- Remove trailing whitespace on save
vim.api.nvim_create_augroup("trim_whitespace", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Trim trailing whitespace on save",
  group = "trim_whitespace",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.setpos(".", save_cursor)
  end,
})
-- Restore cursor position when reopening files
-- vim.api.nvim_create_augroup("restore_cursor", {})
-- vim.api.nvim_create_autocmd("BufReadPost", {
  -- desc = "Restore cursor position when reopening files",
  -- group = "restore_cursor",
  -- callback = function()
    -- local last_pos = vim.fn.line("'\"")
    -- if last_pos > 0 and last_pos <= vim.fn.line("$") then
--      vim.cmd("normal! g`\"")
    -- end
  -- end,
-- })
-- Auto resize splits when resizing nvim window
-- vim.api.nvim_create_augroup("resize_splits", {})
-- vim.api.nvim_create_autocmd("VimResized", {
  -- desc = "Auto resize splits when resizing nvim window",
  -- group = "resize_splits",
  -- callback = function()
    -- vim.cmd("tabdo wincmd =")
  -- end,
-- })

local pre_installed_parsers = {
    "c",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "vim",
    "vimdoc",
}

vim.api.nvim_create_augroup("TSAutoInstallSetup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    group = "TSAutoInstallSetup",
    callback = function(args)
        -- markdown gets treesitter highlighting disabled entirely
        if args.match == "markdown" then
            vim.treesitter.stop(args.buf)
            return
        end

        local treesitter = require("nvim-treesitter")
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and vim.list_contains(treesitter.get_available(), lang) then
            if not vim.list_contains(treesitter.get_installed(), lang)
                and not vim.list_contains(pre_installed_parsers, lang) then
                vim.notify("Installing treesitter parser...", vim.log.levels.WARN)
                treesitter.install(lang):wait()
            end
            vim.treesitter.start(args.buf)
            -- folds, provided by Neovim
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
            -- Activate modern Tree-sitter indentation expressions
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
    desc = "Enable nvim-treesitter (install parser if missing), except for markdown",
})
