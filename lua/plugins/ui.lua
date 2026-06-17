-- UI tweaks borrowed (and trimmed) from abzcoding/nv — same plugins LazyVim
-- already ships, just restyled. Bufferline tabs + lualine status bar.

return {
  -- Tabs: slant separators and a clickable quit button.
  {
    "akinsho/bufferline.nvim",
    init = function()
      -- Clickable region target for the quit button (Vim statusline %@fn@…%X).
      vim.cmd([[
        function! Quit_vim(...) abort
          confirm qall
        endfunction
      ]])
    end,
    opts = {
      options = {
        separator_style = "slant",
        -- A pink quit button pinned to the right edge of the tabline.
        custom_areas = {
          right = function()
            return { { text = "%@Quit_vim@ 󰗼 %X", fg = "#f7768e" } }
          end,
        },
      },
    },
  },

  -- Status bar: extend LazyVim's lualine (don't replace it) with an LSP name,
  -- an animated scrollbar, a macro-recording indicator, and slant separators.
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Attached LSP server name(s) for the current buffer.
      local function lsp_name()
        local names = {}
        for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          if c.name ~= "null-ls" then
            names[#names + 1] = c.name
          end
        end
        return #names > 0 and ("  " .. table.concat(names, ",")) or "  No LSP"
      end

      -- Unicode block tracking scroll position through the file.
      local function scrollbar()
        local chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local total = vim.api.nvim_buf_line_count(0)
        local i = math.floor((cur - 1) / math.max(total - 1, 1) * (#chars - 1)) + 1
        return string.rep(chars[i] or chars[1], 2)
      end

      -- Register being recorded, or empty when not recording.
      local function macro()
        local reg = vim.fn.reg_recording()
        return reg ~= "" and ("󰑊 @" .. reg) or ""
      end

      -- Keep the macro indicator in sync the moment recording starts/stops.
      vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
        group = vim.api.nvim_create_augroup("LualineMacro", { clear = true }),
        callback = function()
          require("lualine").refresh()
        end,
      })

      opts.options = opts.options or {}
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }

      local s = opts.sections
      table.insert(s.lualine_x, 1, { macro, color = { fg = "#ff5f5f", gui = "bold" } })
      table.insert(s.lualine_x, { lsp_name, color = { fg = "#85b5ba" } })
      table.insert(s.lualine_z, { scrollbar, padding = { left = 0, right = 0 } })
    end,
  },
}
