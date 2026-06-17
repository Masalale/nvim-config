-- Override LazyVim's BufWritePre format-on-save to suppress undo pollution.
-- Replaces the default LazyFormat group so formatting never creates undo entries.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LazyFormat", { clear = true }),
  callback = function(event)
    -- Disable undo recording so the format doesn't create an undo entry
    local ul = vim.o.undolevels
    vim.o.undolevels = -1

    pcall(LazyVim.format, { buf = event.buf })

    -- Restore undo
    vim.o.undolevels = ul
  end,
})

-- Auto-save: triggers a normal :w on InsertLeave.
-- This flows through BufWritePre above — format runs (no undo), then saves.
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].modified and vim.bo[buf].buftype == "" then
      vim.cmd("silent! w")
    end
  end,
})
