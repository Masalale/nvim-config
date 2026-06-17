-- Dress up the <leader>e file explorer. Extends LazyVim's neo-tree opts:
-- a source-selector winbar (Files / Buffers / Git), indent guides with
-- expander chevrons, richer git symbols, and follow-the-current-file.

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files" },
        { source = "buffers", display_name = " 󰈚 Buffers" },
        { source = "git_status", display_name = " 󰊢 Git" },
      },
    },
    window = { width = 32 },
    default_component_configs = {
      indent = {
        with_markers = true,
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
      git_status = {
        symbols = {
          added = "✚",
          modified = "",
          deleted = "✖",
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
    filesystem = {
      follow_current_file = { enabled = true, leave_dirs_open = true },
      use_libuv_file_watcher = true,
    },
  },
}
