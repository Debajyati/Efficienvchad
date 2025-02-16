local spec = {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    build = ":call firenvim#install(0)"
}

--[[ if vim.g.started_by_firenvim == true then -- set by the browser addon
  spec = {
    -- { "noice.nvim", cond = false }, -- can't work with gui having ext_cmdline
    { "lualine.nvim", cond = false }, -- not useful in the browser
    vim.tbl_extend("force", spec, {
      lazy = false, -- must load at start in browser
      opts = {
        localSettings = {
          [".*"] = {
            takeover = "never", -- security: activate with ctrl-e
            cmdline = "neovim", -- "firenvim"
          },
        },
      },
      config = function(_, opts)
        if type(opts) == "table" and (opts.localSettings or opts.globalSettings) then
          vim.g.firenvim_config = opts
        end
      end,
    }),
  }
end ]]

return spec
