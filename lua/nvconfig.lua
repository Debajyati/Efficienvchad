local chadrc = require "chadrc"
local colorscheme = "palenight"
if rawget(chadrc.base46, 'theme') then
  colorscheme = chadrc.base46.theme
end

local options = {

  base46 = {
    theme =  colorscheme, -- default theme
    hl_add = {},
    hl_override = {
      -- Visual = vim.api.nvim_get_hl(0, { name = "PmenuSel" })
      Visual = { link = 'pmenusel' },
    },
    integrations = {},
    changed_themes = {},
    transparency = false,
  },

  ui = {
    cmp = {
      icons_left = true, -- only for non-atom styles!
      style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
      border = "rounded", -- single/double/rounded/solid/shadow
      abbr_maxwidth = 60,
      format_colors = {
        tailwind = false, -- will work for css lsp too
        lsp = true,
        icon = "󱓻",
      },
    },

    telescope = { style = "bordered" }, -- borderless / bordered

    statusline = {
      enabled = false,
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = false,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
      bufwidth = 21,
    },
  },

  nvdash = {
    load_on_startup = false,
  },

  term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  lsp = { signature = true },

  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = { pkgs = {}, skip = {} },

  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },

  themepicker = {
     style = "bordered", -- bordered, flat, compact
     border = true,
     icon = nil, -- set it to nil to use default icons preferred by the style
  },
}

return vim.tbl_deep_extend("force", options, {})
