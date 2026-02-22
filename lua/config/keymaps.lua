-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open the LazyVim dashboard with <Space>;
vim.keymap.set("n", "<Space>;", function()
  require("snacks").dashboard()
end, { desc = "Open LazyVim Dashboard" })

-- BufferLinePick: <Space>bj for quick buffer jumping
vim.keymap.set("n", "<Space>bj", "<cmd>BufferLinePick<cr>", { desc = "Jump to buffer (BufferLinePick)" })

-- Alternative buffer navigation: <Space>bn (next), <Space>bp (previous)
vim.keymap.set("n", "<Space>bn", function()
  require("bufferline").cycle(1)
end, { desc = "Next buffer" })

vim.keymap.set("n", "<Space>bp", function()
  require("bufferline").cycle(-1)
end, { desc = "Previous buffer" })


vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })