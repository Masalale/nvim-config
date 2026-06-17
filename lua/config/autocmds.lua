-- Format-on-save: runs inside BufWritePre, formats with undo suppressed,
-- then lets the write complete naturally.
-- This replaces LazyVim's default LazyFormat handler.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LazyFormat", { clear = true }),
  callback = function(event)
    local buf = event.buf
    if not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
      return
    end

    -- Format with undo suppressed — no undo pollution
    local ul = vim.o.undolevels
    vim.o.undolevels = -1
    pcall(LazyVim.format, { buf = buf })
    vim.o.undolevels = ul

    -- Write completes naturally after this callback
  end,
})

-- Auto-save: triggers :w on InsertLeave (immediate) and TextChanged (debounced).
-- Both flow into BufWritePre above → format (no undo) → save.
local save_timer
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
  pattern = "*",
  callback = function(ev)
    local buf = vim.api.nvim_get_current_buf()
    if not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
      return
    end

    -- TextChanged: debounce rapid normal-mode edits
    if ev.event == "TextChanged" then
      if save_timer then
        save_timer:stop()
      end
      save_timer = vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
          vim.cmd("silent! w")
        end
      end, 200)
      return
    end

    -- InsertLeave: save immediately
    vim.cmd("silent! w")
  end,
})
