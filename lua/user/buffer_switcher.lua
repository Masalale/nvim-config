local M = {}

M.minimap_was_open = false

function M.jump_to_buffer()
  local buffers = vim.api.nvim_list_bufs()
  local buffer_list = {}
  local used_chars = {}
  
  local original_win = vim.api.nvim_get_current_win()
  
  -- Check minimap state before anything else
  M.minimap_was_open = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ok, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
    if ok and ft == "minimap" then
      M.minimap_was_open = true
      break
    end
  end
  
  for _, buf in ipairs(buffers) do
    local is_listed = vim.fn.buflisted(buf) == 1
    local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
    local is_normal_buffer = buftype == ""
    
    if is_listed and is_normal_buffer then
      local name = vim.api.nvim_buf_get_name(buf)
      if name and name ~= "" then
        local filename = name:gsub(".*/", "")
        local is_loaded = vim.api.nvim_buf_is_loaded(buf)
        local modified = is_loaded and vim.api.nvim_buf_get_option(buf, "modified") or false
        
        local first_char = filename:sub(1, 1):upper()
        local char = first_char
        local counter = 1
        while used_chars[char] and used_chars[char] ~= buf do
          counter = counter + 1
          if counter > #filename then
            char = tostring(counter)
          else
            char = filename:sub(counter, counter):upper()
          end
        end
        used_chars[char] = buf
        
        table.insert(buffer_list, {
          buf = buf,
          filename = filename,
          name = name,
          modified = modified,
          key = char,
          loaded = is_loaded
        })
      end
    end
  end
  
  if #buffer_list == 0 then
    vim.notify("No file buffers open - open some files first", vim.log.levels.INFO)
    return
  end
  
  local width = 55
  local height = math.min(#buffer_list, 12)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  local lines = {}
  for _, item in ipairs(buffer_list) do
    local mod_char = item.modified and "•" or " "
    local load_indicator = item.loaded and " " or "○"
    table.insert(lines, string.format("%s%s[%s] %s", mod_char, load_indicator, item.key, item.filename))
  end
  
  local menu_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(menu_buf, 0, -1, false, lines)
  
  local menu_win = vim.api.nvim_open_win(menu_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Jump to Buffer (○=unloaded) ",
    title_pos = "center"
  })
  
  for i, item in ipairs(buffer_list) do
    local mod_char = item.modified and "•" or " "
    local load_indicator = item.loaded and " " or "○"
    local prefix_len = #mod_char + #load_indicator + 1
    vim.api.nvim_buf_add_highlight(menu_buf, -1, "BufferSwitcherKey", i - 1, prefix_len, prefix_len + #item.key)
    if item.modified then
      vim.api.nvim_buf_add_highlight(menu_buf, -1, "BufferSwitcherModified", i - 1, 0, #mod_char)
    end
    if not item.loaded then
      vim.api.nvim_buf_add_highlight(menu_buf, -1, "BufferSwitcherUnloaded", i - 1, #mod_char, #mod_char + #load_indicator)
    end
  end
  
  vim.api.nvim_set_hl(0, "BufferSwitcherKey", { fg = "#61AFEF", bold = true })
  vim.api.nvim_set_hl(0, "BufferSwitcherModified", { fg = "#E06C75", bold = true })
  vim.api.nvim_set_hl(0, "BufferSwitcherUnloaded", { fg = "#5C6370", italic = true })
  vim.api.nvim_set_hl(0, "BufferSwitcherSelected", { bg = "#3E4451" })
  
  vim.api.nvim_win_set_option(menu_win, "cursorline", true)
  vim.api.nvim_win_set_option(menu_win, "winhl", "CursorLine:BufferSwitcherSelected")
  
  local menu_closed = false
  
  local function close_menu()
    if menu_closed then return end
    menu_closed = true
    pcall(function()
      if vim.api.nvim_win_is_valid(menu_win) then
        vim.api.nvim_win_close(menu_win, true)
      end
    end)
    pcall(function()
      if vim.api.nvim_buf_is_valid(menu_buf) then
        vim.api.nvim_buf_delete(menu_buf, { force = true })
      end
    end)
  end
  
  local function switch_to_buffer(target_buf)
    local reopen = M.minimap_was_open
    
    -- Close minimap
    if reopen then
      pcall(vim.cmd, "Neominimap off")
    end
    
    -- Close menu
    close_menu()
    
    -- Find non-minimap window
    local target_win = nil
    if vim.api.nvim_win_is_valid(original_win) then
      local buf = vim.api.nvim_win_get_buf(original_win)
      local ok, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
      if ok and ft ~= "minimap" then
        target_win = original_win
      end
    end
    
    if not target_win then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) then
          local buf = vim.api.nvim_win_get_buf(win)
          local ok_ft, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
          local ok_bt, bt = pcall(vim.api.nvim_buf_get_option, buf, "buftype")
          if ok_ft and ok_bt and ft ~= "minimap" and bt == "" then
            target_win = win
            break
          end
        end
      end
    end
    
    -- Switch window and buffer
    if target_win then
      vim.api.nvim_set_current_win(target_win)
    end
    vim.api.nvim_set_current_buf(target_buf)
    
    -- Reopen minimap using feedkeys with correct command
    if reopen then
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(":Neominimap on<CR>", true, false, true),
        "n",
        false
      )
    end
  end
  
  vim.api.nvim_buf_set_keymap(menu_buf, "n", "<Esc>", "", { callback = close_menu, noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(menu_buf, "n", "q", "", { callback = close_menu, noremap = true, silent = true })
  
  vim.api.nvim_buf_set_keymap(menu_buf, "n", "<CR>", "", {
    callback = function()
      local ok, cursor = pcall(vim.api.nvim_win_get_cursor, menu_win)
      if ok and buffer_list[cursor[1]] then
        switch_to_buffer(buffer_list[cursor[1]].buf)
      end
    end,
    noremap = true,
    silent = true
  })
  
  for _, item in ipairs(buffer_list) do
    vim.api.nvim_buf_set_keymap(menu_buf, "n", item.key, "", {
      callback = function() switch_to_buffer(item.buf) end,
      noremap = true, silent = true
    })
    vim.api.nvim_buf_set_keymap(menu_buf, "n", item.key:lower(), "", {
      callback = function() switch_to_buffer(item.buf) end,
      noremap = true, silent = true
    })
  end
  
  for i, item in ipairs(buffer_list) do
    if i <= 9 then
      vim.api.nvim_buf_set_keymap(menu_buf, "n", tostring(i), "", {
        callback = function() switch_to_buffer(item.buf) end,
        noremap = true, silent = true
      })
    end
  end
end

return M
