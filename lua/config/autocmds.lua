-- Add any additional autocmds here

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
