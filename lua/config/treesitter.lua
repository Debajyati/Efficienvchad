---@diagnostic disable: missing-fields
require('nvim-treesitter').setup({
  highlight = {
    enable = true,
    -- Optional: disable for large files
    disable = function(lang, buf)
      local max_filesize = 4 * 1024 * 1024 -- 4 MB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
})

