-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open the LazyVim dashboard with <Space>;
vim.keymap.set("n", "<Space>;", function()
  require("snacks").dashboard()
end, { desc = "Open LazyVim Dashboard" })

-- LunarVim-style buffer switcher: <Space>bj
vim.keymap.set("n", "<Space>bj", function()
  require("user.buffer_switcher").jump_to_buffer()
end, { desc = "Jump to buffer (LunarVim style)" })

-- Alternative buffer navigation: <Space>bn (next), <Space>bp (previous)
vim.keymap.set("n", "<Space>bn", function()
  require("bufferline").cycle(1)
end, { desc = "Next buffer" })

vim.keymap.set("n", "<Space>bp", function()
  require("bufferline").cycle(-1)
end, { desc = "Previous buffer" })
