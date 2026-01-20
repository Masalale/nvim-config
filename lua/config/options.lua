-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.clipboard = "unnamedplus"

-- Add cargo bin to PATH for plugins that need it
local cargo_bin = vim.fn.expand("$HOME/.cargo/bin")
if vim.fn.isdirectory(cargo_bin) == 1 then
  vim.env.PATH = cargo_bin .. ":" .. vim.env.PATH
end
