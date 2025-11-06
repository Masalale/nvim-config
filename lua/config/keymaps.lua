-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open the LazyVim dashboard with <Space>;
vim.keymap.set("n", "<Space>;", function()
  require("snacks").dashboard()
end, { desc = "Open LazyVim Dashboard" })
