-- Format-on-save: format with undo suppressed, then let the write complete.
-- Replaces LazyVim's default LazyFormat handler.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LazyFormat", { clear = true }),
  callback = function(event)
    local buf = event.buf
    if not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
      return
    end

    -- Suppress undo so formatting edits don't pollute the undo history.
    local ul = vim.o.undolevels
    vim.o.undolevels = -1
    pcall(LazyVim.format, { buf = buf })
    vim.o.undolevels = ul
  end,
})

-- Auto-save: :w on InsertLeave (immediate) and TextChanged (debounced).
-- Each write flows into BufWritePre above → format → save.
--
-- One reusable libuv timer instead of a fresh vim.defer_fn per keystroke:
-- defer_fn allocates a new timer handle on every change and leaks it if
-- stopped before firing. Writes target the captured buffer via nvim_buf_call,
-- so a debounced save can't land on the wrong buffer if focus moved while the
-- timer was pending.
local DEBOUNCE_MS = 1000
local timer = assert((vim.uv or vim.loop).new_timer())

local function save(buf)
  -- Never write mid-edit: a debounced save queued in normal mode must not land
  -- after the user has since entered insert/replace mode (format would reflow
  -- text under the cursor while typing).
  if vim.api.nvim_get_mode().mode:match("^[iR]") then
    return
  end
  if not (vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified) then
    return
  end
  -- Skip special buffers and unnamed buffers (nothing to write to).
  if vim.bo[buf].buftype ~= "" or vim.api.nvim_buf_get_name(buf) == "" then
    return
  end
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! write")
  end)
end

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave", "TextChanged" }, {
  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
  callback = function(ev)
    -- Entering insert: kill any pending debounced save so it can't fire while
    -- you're typing.
    if ev.event == "InsertEnter" then
      timer:stop()
      return
    end

    local buf = ev.buf
    if not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
      return
    end

    timer:stop() -- cancel any pending debounced save
    if ev.event == "TextChanged" then
      -- Debounce rapid normal-mode edits.
      timer:start(DEBOUNCE_MS, 0, vim.schedule_wrap(function()
        save(buf)
      end))
    else
      -- InsertLeave: save immediately.
      save(buf)
    end
  end,
})
