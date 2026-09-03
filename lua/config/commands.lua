-- LspInfo command

local function show_lsp_info_float()
  -- 1. Fetch active clients for the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if vim.tbl_isempty(clients) then
    vim.notify("No active LSP clients attached to this buffer", vim.log.levels.WARN)
    return
  end

  -- 2. Build the output content lines
  local lines = { "vim.lsp: Active Clients ~" }

  for _, client in ipairs(clients) do
    table.insert(lines, string.format("- %s (id: %s)", client.name, client.id))

    -- Extract version if available
    local version = client.config and client.config.cmd_env and client.config.cmd_env.VERSION or "unknown"
    table.insert(lines, string.format("  - Version: %s", version))
    table.insert(lines, string.format("  - Root directory: %s", client.config.root_dir or "nil"))

    -- Format command array
    local cmd_str = vim.inspect(client.config.cmd):gsub("\n", ""):gsub("%s+", " ")
    table.insert(lines, string.format("  - Command: %s", cmd_str))

    -- Format settings block with proper indentation
    table.insert(lines, "  - Settings: {")
    local settings_inspect = vim.inspect(client.config.settings)
    for setting_line in settings_inspect:gmatch("[^\r\n]+") do
      if setting_line ~= "{" and setting_line ~= "}" then
        table.insert(lines, "    " .. setting_line)
      end
    end
    table.insert(lines, "    }")

    -- Count attached buffers
    local attached_bufs = vim.tbl_keys(client.attached_buffers or {})
    table.insert(lines, string.format("  - Attached buffers: %d", #attached_bufs))
  end

  -- 3. Create an ephemeral scratch buffer
  local info_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)
  vim.bo[info_buf].filetype = "lua" -- Adds syntax highlighting to the text/settings
  vim.bo[info_buf].modifiable = false

  -- 4. Calculate floating window size and position
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.min(80, ui.width - 10)
  local height = math.min(#lines + 2, ui.height - 10)
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  -- 5. Open the floating window and focus it
  local win = vim.api.nvim_open_win(info_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " LSP Information ",
    title_pos = "center",
  })

  -- 6. Map 'q' to close the window instantly
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = info_buf, silent = true, nowait = true })
end

-- 7. Bind the function to the :LspInfo command
vim.api.nvim_create_user_command("LspInfo", show_lsp_info_float,
  { desc = "Get the LSP clients and their settings which are attched to the current buffer" })


-- LspClients command
vim.api.nvim_create_user_command("LspClients", function()
  local lspClients = vim.iter(vim.lsp.get_clients({ bufnr = 0 })):map(function(c) return c.name end):totable()
  vim.print(lspClients)
end, {desc = "Get only the names of the LSP clients which are attched to the current buffer"})

