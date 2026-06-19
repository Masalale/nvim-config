-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.clipboard = "unnamedplus"

-- Wrap long lines to the next line instead of running off-screen (and, with
-- the neominimap split, hiding under the minimap). linebreak wraps at word
-- boundaries; breakindent keeps wrapped rows aligned with the line's indent.
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Highlight the current line (subtle on unokai's #3a392f). Word-under-cursor
-- occurrences come from vim-illuminate (the editor.illuminate extra).
vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"

-- Add cargo bin to PATH for plugins that need it
local cargo_bin = vim.fn.expand("$HOME/.cargo/bin")
if vim.fn.isdirectory(cargo_bin) == 1 then
  vim.env.PATH = cargo_bin .. ":" .. vim.env.PATH
end
