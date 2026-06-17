-- Format on Save (with auto-save built in).
--
-- Triggered on InsertLeave → formats the buffer → saves.
--
-- Undo is suppressed during format so it stays invisible to undo history.
-- Pressing `u` only sees your edits, never the formatting.
--
-- This is the ONE mechanism. There is no separate auto-save plugin and no
-- separate BufWritePre handler. Auto-save is just format-on-save triggering
-- on InsertLeave.
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
      return
    end

    -- Format with undo suppressed so it doesn't pollute undo history
    local ul = vim.o.undolevels
    vim.o.undolevels = -1
    pcall(LazyVim.format, { buf = buf })
    vim.o.undolevels = ul

    -- Save (using noautocmd to avoid re-triggering ourselves)
    vim.cmd("silent! noautocmd w")
  end,
})
