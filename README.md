# Efficienvchad

> **Requirements:** Neovim 0.11 or above · A [Nerd Font](https://www.nerdfonts.com/) (required for icons)

## Description

**Efficienvchad** is the NVCHADification of [Efficienvim](https://github.com/Debajyati/Efficienvim). Efficienvim is a Neovim configuration that aims to be as minimal as possible while remaining highly customizable. Efficienvchad takes that foundation and partially integrates [nvchad-ui](https://github.com/nvchad/ui) and [base46](https://github.com/nvchad/base46) on top, adding aesthetic theming, a beautiful completion menu, and NvChad's colorify/themepicker.

Key properties:

- Uses **lazy.nvim** as the package manager
- Uses **Neovim's native LSP API** (`vim.lsp.config`) instead of classic `nvim-lspconfig` setups
- **Transparent background** enabled by default
- **Auto-installs Tree-sitter parsers** on first open of any filetype

---

## Installation & Usage

### As a template (recommended)

Press the **"Use this template"** button on GitHub to create your own repository, then clone it:

```bash
# Linux / macOS
git clone https://github.com/<your-username>/Efficienvchad.git ~/.config/nvim
```

### Direct clone (no personal tracking)

```bash
# Linux / macOS
git clone https://github.com/Debajyati/Efficienvchad.git ~/.config/nvim
```

### Windows

**cmd.exe:**

```batch
git clone https://github.com/<your-username>/Efficienvchad.git %LOCALAPPDATA%\nvim
```

**PowerShell:**

```pwsh
git clone https://github.com/<your-username>/Efficienvchad.git $env:LOCALAPPDATA\nvim
```

On first launch Neovim will automatically bootstrap **lazy.nvim** and install all plugins.

---

## File & Directory Structure

```
.
├── after/
│   └── ftplugin/
│       └── markdown.lua        ← filetype-specific cmp sources for Markdown
├── lua/
│   ├── chadrc.lua              ← your NvChad UI overrides (theme, transparency, …)
│   ├── nvconfig.lua            ← default NvChad configuration (avoid editing directly)
│   ├── config/
│   │   ├── options.lua         ← core Neovim options
│   │   ├── lazy.lua            ← lazy.nvim bootstrapper & plugin spec loader
│   │   ├── keymaps.lua         ← global keymaps
│   │   ├── autocmds.lua        ← autocommands (yank highlight, whitespace trim, TS auto-install)
│   │   ├── lspsettings.lua     ← native LSP attach, Mason, nvim-cmp, per-server configs
│   │   ├── noicesettings.lua   ← Noice UI setup (cmdline, messages, popupmenu)
│   │   ├── notify-settings.lua ← nvim-notify appearance
│   │   ├── nvim-tree.lua       ← NvimTree file explorer setup & keymaps
│   │   ├── telescope.lua       ← Telescope setup (ivy/dropdown themes, pickers)
│   │   ├── treesitter.lua      ← nvim-treesitter highlight + large-file guard
│   │   ├── commands.lua        ← custom user commands (:LspInfo, :LspClients)
│   │   └── terminal.lua        ← toggleterm basic setup
│   ├── plugins/
│   │   ├── base.lua            ← all core plugin specs (DO NOT edit unless you know what you're doing)
│   │   └── nvui.lua            ← NvChad UI plugin specs (nvchad/ui, nvzone/volt, nvchad/base46)
│   └── extras/                 ← drop your own extra plugin specs here (loaded automatically)
└── init.lua                    ← entry point: sets leader, loads config modules, applies transparency
```

### Directory Notes

| Path                     | Purpose                                                           |
| ------------------------ | ----------------------------------------------------------------- |
| `lua/chadrc.lua`       | Configure NvChad theming: active theme, toggle pair, transparency |
| `lua/nvconfig.lua`     | NvChad defaults — prefer`chadrc.lua` for overrides             |
| `lua/config/`          | Efficienvchad's core configuration modules                        |
| `lua/plugins/base.lua` | Managed plugin list — edit with care                             |
| `lua/plugins/nvui.lua` | NvChad UI integration plugins                                     |
| `lua/extras/`          | **Your place** to add extra plugins or custom modules       |
| `after/ftplugin/`      | Filetype-specific configs loaded after`init.lua`                |

---

## Plugins

### UI & Aesthetics

| Plugin                            | Role                                                        |
| --------------------------------- | ----------------------------------------------------------- |
| `nvchad/ui` + `nvchad/base46` | NvChad UI shell, base46 colorscheme engine                  |
| `nvzone/volt`                   | Volt reactive UI library (required by NvChad)               |
| `nvim-lualine/lualine.nvim`     | Status line                                                 |
| `akinsho/bufferline.nvim`       | Buffer/tab line with LSP diagnostics indicators             |
| `lunarvim/darkplus.nvim`        | Extra colorscheme (`darkplus`, set as default at startup) |
| `rcarriga/nvim-notify`          | Fancy notification popups                                   |
| `folke/noice.nvim`              | Replaces cmdline, messages, and popupmenu with rich UI      |
| `stevearc/dressing.nvim`        | Improves`vim.ui.select` / `vim.ui.input`                |

### LSP & Completion

| Plugin                                | Role                                                         |
| ------------------------------------- | ------------------------------------------------------------ |
| `neovim/nvim-lspconfig`             | LSP client infrastructure                                    |
| `williamboman/mason.nvim`           | LSP / linter / formatter installer                           |
| `williamboman/mason-lspconfig.nvim` | Bridge between Mason and nvim-lspconfig                      |
| `nvimdev/lspsaga.nvim`              | Enhanced LSP UI (peek definition, code actions, diagnostics) |
| `hrsh7th/nvim-cmp`                  | Completion engine                                            |
| `hrsh7th/cmp-nvim-lsp`              | LSP completion source                                        |
| `hrsh7th/cmp-buffer`                | Buffer-word completion source                                |
| `hrsh7th/cmp-path`                  | Filesystem path completion source                            |
| `hrsh7th/cmp-cmdline`               | Command-line completion source                               |
| `hrsh7th/cmp-nvim-lua`              | Neovim Lua API completion source                             |
| `octaltree/cmp-look`                | English-word completion source                               |
| `L3MON4D3/LuaSnip`                  | Snippet engine                                               |
| `rafamadriz/friendly-snippets`      | Pre-made snippet collection                                  |
| `saadparwaiz1/cmp_luasnip`          | LuaSnip completion source                                    |
| `onsails/lspkind.nvim`              | VSCode-style pictograms for completion items                 |
| `folke/lazydev.nvim`                | Lua LS type support for Neovim config development            |

### Syntax & Navigation

| Plugin                                       | Role                                                      |
| -------------------------------------------- | --------------------------------------------------------- |
| `nvim-treesitter/nvim-treesitter`          | Syntax highlighting; parsers auto-installed on first open |
| `nvim-telescope/telescope.nvim`            | Fuzzy finder (files, buffers, git, grep)                  |
| `nvim-telescope/telescope-fzf-native.nvim` | Native FZF sorter for Telescope                           |
| `nvim-tree/nvim-tree.lua`                  | File explorer tree sidebar                                |
| `nvim-tree/nvim-web-devicons`              | File-type icons                                           |
| `christoomey/vim-tmux-navigator`           | Seamless pane navigation between Neovim & tmux            |

### Git

| Plugin                     | Role                                    |
| -------------------------- | --------------------------------------- |
| `tpope/vim-fugitive`     | Full git wrapper inside Neovim          |
| `sindrets/diffview.nvim` | Side-by-side diff & file history viewer |
| `kdheepak/lazygit.nvim`  | Floating lazygit TUI integration        |

### Editing & Utilities

| Plugin                      | Role                                                                 |
| --------------------------- | -------------------------------------------------------------------- |
| `windwp/nvim-autopairs`   | Auto-close brackets/quotes (Tree-sitter aware)                       |
| `kylechui/nvim-surround`  | Add/change/delete surrounding characters                             |
| `Wansmer/treesj`          | Split/join blocks of code (e.g. function args)                       |
| `mbbill/undotree`         | Visual undo history tree                                             |
| `nvimtools/none-ls.nvim`  | Formatting & linting via null-ls sources (prettier, black, eslint_d) |
| `akinsho/toggleterm.nvim` | Persistent terminal windows (horizontal, vertical, float)            |
| `folke/which-key.nvim`    | Keymap hint popup on timeout                                         |
| `folke/trouble.nvim`      | Pretty diagnostics, references, and quickfix list                    |
| `folke/edgy.nvim`         | Predefined editor layout (pins Trouble to bottom)                    |

---

## Keymaps

> **Leader key:** `<Space>`

### Global (Normal Mode)

| Keymap         | Action                                   |
| -------------- | ---------------------------------------- |
| `<leader>ff` | Find files (Telescope)                   |
| `<leader>r`  | Recent files (Telescope oldfiles)        |
| `<leader>gf` | Git files (Telescope)                    |
| `<leader>ps` | Grep string (Telescope live grep prompt) |
| `<leader>bf` | Find open buffers (Telescope)            |
| `<leader>cc` | Open NvChad theme picker                 |
| `<leader>gs` | Open vim-fugitive (`:Git`)             |
| `<leader>u`  | Toggle undotree                          |
| `<leader>e`  | Toggle NvimTree sidebar                  |
| `<leader>E`  | Reveal current file in NvimTree          |
| `<leader>fr` | Format document (none-ls / LSP)          |

### Terminal

| Keymap         | Action                   |
| -------------- | ------------------------ |
| `<leader>th` | Open horizontal terminal |
| `<leader>tv` | Open vertical terminal   |
| `<leader>tf` | Open floating terminal   |

### Window Navigation (vim-tmux-navigator)

| Keymap    | Action         |
| --------- | -------------- |
| `<C-h>` | Navigate left  |
| `<C-j>` | Navigate down  |
| `<C-k>` | Navigate up    |
| `<C-l>` | Navigate right |

### Buffer Navigation (bufferline)

| Keymap      | Action          |
| ----------- | --------------- |
| `<Tab>`   | Next buffer     |
| `<S-Tab>` | Previous buffer |

### LSP (active when an LSP client is attached)

| Keymap   | Action                            |
| -------- | --------------------------------- |
| `K`    | Hover documentation               |
| `gs`   | Signature help                    |
| `gd`   | Go to definition (Lspsaga)        |
| `gD`   | Go to declaration                 |
| `gp`   | Peek definition (Lspsaga)         |
| `gi`   | Go to implementation              |
| `go`   | Go to type definition (Lspsaga)   |
| `gr`   | List references                   |
| `gl`   | Show line diagnostics (Lspsaga)   |
| `gL`   | Show buffer diagnostics (Lspsaga) |
| `[d`   | Previous diagnostic               |
| `]d`   | Next diagnostic                   |
| `<F2>` | Rename symbol                     |
| `<F3>` | Format buffer (async)             |
| `<F4>` | Code action (Lspsaga)             |

### NvimTree (inside the tree window)

| Keymap                              | Action                        |
| ----------------------------------- | ----------------------------- |
| `l` / `<CR>` / `double-click` | Open file / expand directory  |
| `h`                               | Close directory               |
| `L`                               | Change root to node (cd into) |
| `H`                               | Go up to parent root          |
| `<Tab>`                           | Preview file                  |
| `<C-s>`                           | Open in horizontal split      |
| `<C-v>`                           | Open in vertical split        |
| `<C-t>`                           | Open in new tab               |
| `c`                               | Create file/directory         |
| `r`                               | Rename                        |
| `<C-r>`                           | Rename (omit filename)        |
| `d`                               | Cut                           |
| `y`                               | Copy                          |
| `p`                               | Paste                         |
| `D`                               | Trash                         |
| `R`                               | Refresh tree                  |
| `f`                               | Live filter                   |
| `-`                               | Collapse all                  |
| `s`                               | Open with system app          |
| `t`                               | Toggle bookmark               |
| `P`                               | Move all bookmarked files     |
| `gyn`                             | Copy filename                 |
| `gyp`                             | Copy relative path            |
| `gya`                             | Copy absolute path            |
| `K`                               | Show node info popup          |
| `<` / `>`                       | First / last sibling          |

### Completion (nvim-cmp, Insert Mode)

| Keymap                  | Action                                                    |
| ----------------------- | --------------------------------------------------------- |
| `<CR>`                | Confirm selected item                                     |
| `<C-Space>`           | Trigger completion menu                                   |
| `<C-k>` / `<C-j>`   | Select previous / next item                               |
| `<Tab>` / `<S-Tab>` | Select next / previous item (or jump snippet placeholder) |
| `<C-b>` / `<C-f>`   | Scroll docs up / down                                     |
| `<C-c>`               | Abort / close completion                                  |

---

## LSP Support

LSP servers are managed via **Mason** and configured using Neovim's native `vim.lsp.config` API. Pre-configured servers include:

| Language                          | Server                                                                       |
| --------------------------------- | ---------------------------------------------------------------------------- |
| HTML / Django / Jinja / JSX / TSX | `html` (extended filetypes)                                                |
| CSS / Tailwind                    | `tailwindcss` (with htmldjango, jinja, eelixir, eruby support)             |
| TypeScript / JavaScript           | `tsserver` (Node.js projects via `package.json` / `tsconfig.json`)     |
| Deno                              | `denols` (Deno projects via `deno.json` / `deno.jsonc`)                |
| Django                            | `djlsp` (projects with `manage.py`)                                      |
| Rust                              | `rust_analyzer` (with clippy + full code lens)                             |
| Lua                               | `lua_ls` (via `lazydev.nvim` for Neovim API types)                       |
| Others                            | Any server installable via Mason (auto-configured with default capabilities) |

Formatting is handled by **none-ls** with:

- `prettier` — JS/TS/HTML/CSS
- `black` — Python
- `eslint_d` — ESLint diagnostics (only when `eslint.config.js/cjs/mjs` is present)

---

## Custom Commands

| Command         | Description                                                                                                       |
| --------------- | ----------------------------------------------------------------------------------------------------------------- |
| `:LspInfo`    | Floating window with active LSP clients, root dir, command, settings, and attached buffers for the current buffer |
| `:LspClients` | Print a list of active LSP client names for the current buffer                                                    |

---

## Theming & Appearance

Efficienvchad uses NvChad's **base46** colorscheme engine. The active theme is configured in `lua/chadrc.lua`:

```lua
M.base46 = {
  theme = "material-deep-ocean",         -- active theme
  transparency = true,                    -- transparent background
  theme_toggle = { "palenight", "chadracula_evondev" },  -- toggle pair for <leader>cc
}
```

The default colorscheme applied at startup (via `vim.cmd`) is `darkplus` (from `lunarvim/darkplus.nvim`); base46 themes layer on top.

To change theme interactively: press **`<leader>cc`** to open the NvChad theme picker.

---

## Customization

### Adding extra plugins

Drop a Lua file returning a lazy.nvim spec table into **`lua/extras/`**. It is automatically imported by `lazy.lua` — no other changes needed.

Example: `lua/extras/my-plugin.lua`

```lua
return {
  {
    "author/my-plugin.nvim",
    event = "VeryLazy",
    config = function()
      require("my-plugin").setup({})
    end,
  }
}
```

### Enabling spell checking

In `init.lua`, uncomment the block for your filetype:

```lua
-- vim.cmd [[ autocmd FileType markdown setlocal spell ]]
-- vim.cmd [[ autocmd FileType text setlocal spell ]]
-- vim.cmd [[ autocmd FileType gitcommit setlocal spell ]]
-- vim.cmd [[ autocmd FileType tex setlocal spell ]]
```

The spell language is set to `en_us` by default (`vim.opt.spelllang = 'en_us'`).

### Clipboard (WSL / clipboard managers)

In `lua/config/options.lua`, `unnamedplus` is enabled by default for seamless system clipboard integration. For WSL with xclip, uncomment:

```lua
vim.api.nvim_set_keymap("v", "<C-c>", ":w !xclip -i -sel c<CR><CR>", { noremap = true })
```

---

## Notable Behaviours

- **Transparent background** — applied via `VimEnter` autocommands in `init.lua` (Normal, NormalNC, VertSplit, StatusLine, LineNr, NonText).
- **Yank highlight** — briefly highlights yanked text using the `IncSearch` group (200 ms timeout).
- **Trailing whitespace** — automatically stripped on every `BufWritePre`.
- **Tree-sitter auto-install** — when you open a filetype whose parser is not installed, it is downloaded automatically and Tree-sitter highlighting, folding, and indentation are activated. **Markdown is intentionally excluded** (Tree-sitter is stopped for it; use native Neovim highlighting instead).
- **Markdown completion** — `after/ftplugin/markdown.lua` customizes cmp sources to prefer snippets and English-word look-ups over LSP.
- **Large-file guard** — Tree-sitter highlighting is disabled for files larger than **4 MB**.
- **netrw disabled** — `nvim-tree` is used as the file explorer; netrw is disabled at startup.
- **Diagnostics** — virtual text is shown only for the current line, and diagnostics are sorted by severity.

---

## License

MIT
