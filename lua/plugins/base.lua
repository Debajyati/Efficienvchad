---@diagnostic disable: missing-fields

local specs = {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  { "stevearc/dressing.nvim" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      {
        "nvimdev/lspsaga.nvim",
        event = "VeryLazy",
        config = function()
          require('lspsaga').setup({})
        end,
      },
      {
        "williamboman/mason.nvim",
        cmd = {
          "Mason",
          "MasonInstall",
          "MasonUninstall",
          "MasonUninstallAll",
          "MasonLog",
        }, -- Package Manager
        dependencies = "williamboman/mason-lspconfig.nvim",
        config = function()
          local mason = require("mason")

          require("lspconfig.ui.windows").default_options.border = "rounded"

          mason.setup({
            ui = {
              -- Whether to automatically check for new versions when opening the :Mason window.
              check_outdated_packages_on_open = false,
              border = "single",
              icons = {
                package_installed = "",
                package_pending = "",
                package_uninstalled = "󰚌",
              },
            },
          })
        end,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "elixir", "javascript", "html", "go", "java",
          "python", "rust", "tsx", "typescript", "css", "json", "bash", "yaml", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = true, },
        indent = { enable = true },
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      "CmdlineEnter"
    },
    dependencies = {
      "hrsh7th/cmp-buffer",           -- Buffer Completions
      "hrsh7th/cmp-path",             -- Path Completions
      "saadparwaiz1/cmp_luasnip",     -- Snippet Completions
      "hrsh7th/cmp-nvim-lsp",         -- LSP Completions
      "hrsh7th/cmp-nvim-lua",         -- Lua Completions
      "hrsh7th/cmp-cmdline",          -- CommandLine Completions
      "octaltree/cmp-look",           -- English Completions
      "L3MON4D3/LuaSnip",             -- Snippet Engine
      "rafamadriz/friendly-snippets", -- Bunch of Snippets
      "windwp/nvim-autopairs",        -- autopairs
      "onsails/lspkind.nvim",         -- vscode like pictograms
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.fn.stdpath "config" .. "/snippets/snipmate" }
      require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_vscode").lazy_load { paths = vim.fn.stdpath "config" .. "/snippets/vscode" }

      local kind_icons = {
        Namespace = "󰌗 ",
        Text = "󰉿 ",
        Method = "󰆧 ",
        Function = "󰡱 ",
        Constructor = " ",
        Field = "󰜢 ",
        Private = " ",
        Variable = "󰀫 ",
        Class = "󰠱 ",
        Interface = " ",
        Module = " ",
        Property = "󰜢 ",
        Unit = "󰑭 ",
        Value = "󰎠 ",
        Enum = " ",
        Keyword = "󰌋 ",
        Snippet = " ",
        Color = "󰏘 ",
        File = "󰈚 ",
        Reference = "󰈇 ",
        Folder = "󰉋 ",
        EnumMember = " ",
        Constant = "󰏿 ",
        Struct = "󰙅 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
        Table = " ",
        Object = "󰅩 ",
        Tag = " ",
        Array = "[]",
        Boolean = " ",
        Number = " ",
        Null = "󰟢 ",
        String = "󰉿 ",
        Calendar = " ",
        Watch = "󰥔 ",
        Package = " ",
        Copilot = " ",
        Codeium = " ",
        TabNine = " ",
        Supermaven = " ",
      }
      require("lspkind").setup({
        mode = 'symbol_text',
      })

      local Truncate = function(text, max_width)
        if #text > max_width then
          return string.sub(text, 1, max_width) .. "…"
        else
          return text
        end
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        mapping = cmp.mapping.preset.insert {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
          ---@diagnostic disable-next-line: missing-parameter
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          -- Abort auto completion
          ["<C-c>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "double",
          }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "buffer" },
          {
            name = "look",
            keyword_length = 2,
            option = {
                convert_case = true,
                loud = true
                --dict = '/usr/share/dict/words'
            }
          },
          { name = "path" },
        },
        formatting = {
          format = function(entry, vim_item)
            local lspkind = require("lspkind")
            local max_abbr_item_width = 40
            local max_detail_item_width = 40
            -- Truncate the item if it is too long
            vim_item.abbr = Truncate(vim_item.abbr, max_abbr_item_width)
            -- fancy icons and a name of kind
            vim_item.kind_symbol = (lspkind.symbolic or lspkind.get_symbol)(vim_item.kind)
            vim_item.kind = " " .. vim_item.kind_symbol .. " " .. vim_item.kind
            -- The 'menu' section: source, detail information (lsp, snippet), etc.
            -- set a name for each source (see the sources section below)
            vim_item.menu = ({
              buffer = "Buffer",
              nvim_lsp = "LSP",
              nvim_lua = "Lua",
              latex_symbols = "Latex",
            })[entry.source.name] or string.format("%s", entry.source.name)

            -- highlight groups for item.menu
            vim_item.menu_hl_group = ({
              buffer = "CmpItemMenuBuffer",
              nvim_lsp = "CmpItemMenuLSP",
              path = "CmpItemMenuPath",
            })[entry.source.name] -- default is CmpItemMenu
            -- detail information (optional)
            local cmp_item = entry:get_completion_item()

            if entry.source.name == "nvim_lsp" then
              -- Display which LSP servers this item came from.
              local lspserver_name = nil
              pcall(function()
                lspserver_name = entry.source.source.client.name
                vim_item.menu = lspserver_name
              end)

              -- Some language servers provide details, e.g. type information.
              -- The details info hide the name of lsp server, but mostly we'll have one LSP
              -- per filetype, and we use special highlights so it's OK to hide it..
              local detail_txt = (function(cmp_item)
                if not cmp_item.detail then
                  return nil
                end

                if lspserver_name == "pyright" and cmp_item.detail == "Auto-import" then
                  local label = (cmp_item.labelDetails or {}).description
                  return label and (" " .. Truncate(label, 20)) or nil
                else
                  return Truncate(cmp_item.detail, max_detail_item_width)
                end
              end)(cmp_item)
              if detail_txt then
                vim_item.menu = detail_txt
                vim_item.menu_hl_group = "CmpItemMenuDetail"
              end
            end

            -- Add a little bit more padding
            vim_item.menu = " " .. vim_item.menu
            return vim_item
          end,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        experimental = {
          ghost_text = true,
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline" },
        },
        formatting = {
          -- fields = { 'abbr' },
          format = function(_, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            return vim_item
          end,
        },
      })
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = "VeryLazy",
    -- enabled = false,
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    end

  },

  { "mbbill/undotree", event = "VeryLazy" },

  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- This is only git plugin a user can need.
  -- Although I provided more after.
  { "tpope/vim-fugitive", event = "VeryLazy" },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFocusFiles", "DiffviewToggleFiles", "DiffviewRefresh" },
  },

  {
    'akinsho/bufferline.nvim',
    -- enabled = false,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "BufWinEnter",
    config = function()
      local status_ok, bufferline = pcall(require, "bufferline")
      if not status_ok then return end
      require("bufferline").setup({
        options = {
          offsets = {
            {
              filetype = "neo-tree",
              text = "EXPLORER",
              padding = 0,
              text_align = "center",
              highlight = "Offset",
            },
            {
              filetype = "NvimTree",
              text = "EXPLORER",
              padding = 0,
              text_align = "center",
              highlight = "Offset",
            },
          },
          -- buffer_close_icon = "",
          modified_icon = "●",
          -- close_icon = "",
          -- close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
          max_name_length = 18,
          max_prefix_length = 15,       -- prefix used when a buffer is de-duplicated
          truncate_names = true,        -- whether or not tab names should be truncated
          tab_size = 18,
          diagnostics = "nvim_lsp",     -- | "nvim_lsp" | "coc",
          -- separator_style = "slant", -- | "thick" | "thin" | "slope" | { 'any', 'any' },
          separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
          indicator = {
            -- icon = " ",
            -- style = 'icon',
            -- style = "underline",
          },

          numbers = "none",                        -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          -- close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
          right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
          left_mouse_command = "buffer %d",        -- can be a string | function, see "Mouse actions"
          middle_mouse_command = nil,              -- can be a string | function, see "Mouse actions"
          -- NOTE: this plugin is designed with this icon in mind,
          -- and so changing this is NOT recommended, this is intended
          -- as an escape hatch for people who cannot bear it for whatever reason
          buffer_close_icon = "",
          close_icon = '',
          left_trunc_marker = "",
          right_trunc_marker = "",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            if count > 9 then return "9+" end
            return tostring(count)
          end,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          enforce_regular_tabs = false,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          -- can also be a table containing 2 custom separators
          -- [focused and unfocused]. eg: { '|', '|' }
          always_show_bufferline = true,
          sort_by = "insert_after_current",
          -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
          --   -- add custom logic
          --   return buffer_a.modified > buffer_b.modified
          -- end
          hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
          },
        },
      })
      vim.cmd [[
            nnoremap <silent><TAB> :BufferLineCycleNext<CR>
            nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
            ]]
    end
  },

  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
      local execs = {
        { nil, "<space>th", "Horizontal Terminal", "horizontal", 0.3 },
        { nil, "<space>tv", "Vertical Terminal",   "vertical",   0.4 },
        { nil, "<space>tf", "Float Terminal",      "float",      nil },
      }

      local function get_buf_size()
        local cbuf = vim.api.nvim_get_current_buf()
        local bufinfo = vim.tbl_filter(function(buf)
          return buf.bufnr == cbuf
        end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
        if bufinfo == nil then
          return { width = -1, height = -1 }
        end
        return { width = bufinfo.width, height = bufinfo.height }
      end

      local function get_dynamic_terminal_size(direction, size)
        size = size
        if direction ~= "float" and tostring(size):find(".", 1, true) then
          size = math.min(size, 1.0)
          local buf_sizes = get_buf_size()
          local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
          return buf_size * size
        else
          return size
        end
      end

      local exec_toggle = function(opts)
        local Terminal = require("toggleterm.terminal").Terminal
        local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
        term:toggle(opts.size, opts.direction)
      end

      local add_exec = function(opts)
        local binary = opts.cmd:match "(%S+)"
        if vim.fn.executable(binary) ~= 1 then
          vim.notify("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
          return
        end

        vim.keymap.set("n", opts.keymap, function()
          exec_toggle { cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size() }
        end, { desc = opts.label, noremap = true, silent = true })
      end

      for i, exec in pairs(execs) do
        local direction = exec[4]

        local opts = {
          cmd = exec[1] or vim.o.shell,
          keymap = exec[2],
          label = exec[3],
          count = i + 100,
          direction = direction,
          size = function()
            return get_dynamic_terminal_size(direction, exec[5])
          end,
        }

        add_exec(opts)
      end

      vim.cmd [[
          augroup terminal_setup | au!
          autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i
          autocmd TermEnter * startinsert!
          augroup end
          ]]

      vim.api.nvim_create_autocmd({ "TermEnter" }, {
        pattern = { "*" },
        callback = function()
          vim.cmd "startinsert"
          _G.set_terminal_keymaps()
        end,
      })

      local opts = { noremap = true, silent = true }
      function _G.set_terminal_keymaps()
        vim.api.nvim_buf_set_keymap(0, "t", "<C-n><C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-n><C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-n><C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-n><C-l>", [[<C-\><C-n><C-W>l]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-n>", [[<C-\><C-n>]], opts)
      end
    end
  },

  { "lunarvim/darkplus.nvim", event = "VeryLazy" },
  -- sleek git integration
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
  },
  -- a plugin, when triggered will show your beloved keybindings,
  -- so that you won't need to memorise them.
  -- needs to be configured properly to show what the keymaps do,
  -- otherwise it will show only the keymaps
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- follow this link - https://github.com/folke/which-key.nvim to know how to configure
      -- which-key based on your own and default plugins keybindings
      -- or leave it empty to use the default settings
    },
  },
  -- for formatting and linting
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,
        sources = {
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          require("none-ls.diagnostics.eslint_d").with({
            condition = function(utls)
              return utls.root_has_file({
                "eslint.config.js",
                "eslint.config.cjs",
                "eslint.config.mjs",
              })
            end,
          }),
        },
      })

      vim.keymap.set({ "n", "v" }, "<space>fr", vim.lsp.buf.format, { desc = "format document" })
    end,
  },
  -- NvimTree: file-explorer tree view at left sidebar
  {
    "nvim-tree/nvim-tree.lua",
    name = 'nvim-tree',
  },
  -- ui for messages, commandline & the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
      },
    },
  },
  -- Better help with code diagnostics
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    cmd = { "TroubleToggle", "Trouble" },

    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = "<c-e>",
      },
    },
  },
  -- plugin to change surroundings of text/code
  {
    "kylechui/nvim-surround",
    version = '*',
    event = "VeryLazy",
    opts = {},
    config = function()
      require("nvim-surround").setup({})
    end
  },
  -- for splitting/joining blocks of code
  {
    'Wansmer/treesj',
    event = "VeryLazy",
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({ --[[ your config ]] })
    end,
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    optional = true,
    opts = function(_, opts)
      if not opts.bottom then opts.bottom = {} end
      table.insert(opts.bottom, "Trouble")
    end,
  },
  {
    "ficcdaf/academic.nvim",
    -- optional: only load for certain filetypes
    ft = {"markdown", "tex"},
    config = function ()
      require("academic").load()
    end
  }
}

return specs
