-- Auto-save + Format on InsertLeave
-- Formats the buffer then saves, without polluting undo history.
-- Pressing `u` undoes your typing edit — the formatting is invisible to undo.
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("AutoSaveFormat", { clear = true }),
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    -- Only save modifiable real files (not help, quickfix, etc.)
    if not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
      return
    end

    -- Disable undo recording so the format doesn't create an undo entry
    local undo_levels = vim.o.undolevels
    vim.o.undolevels = -1

    -- Format via conform (LazyVim's formatter)
    pcall(function()
      require("conform").format({ bufnr = buf, async = false })
    end)

    -- Re-enable undo
    vim.o.undolevels = undo_levels

    -- Save without triggering BufWritePre (no re-format)
    vim.cmd("silent! noautocmd w")
  end,
})
