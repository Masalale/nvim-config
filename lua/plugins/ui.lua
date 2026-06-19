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

      -- VS Code Monokai palette → an explicit, high-contrast lualine theme.
      -- The unokai-derived "auto" theme washed the bar out; this keeps each
      -- mode's accent bright against a dark Monokai background so the status
      -- line stays legible regardless of the editor colorscheme.
      local mono = {
        bg = "#272822", -- background
        fg = "#F8F8F2", -- foreground
        green = "#A6E22E",
        blue = "#66D9EF",
        purple = "#AE81FF",
        pink = "#F92672", -- (brightRed)
        yellow = "#E6DB74",
        sel = "#49483E", -- selectionBackground → b sections
        c_bg = "#383830", -- a touch lighter than bg so section c stays distinct
        dim = "#75715E", -- Monokai comment grey — legible (~3.5:1) for inactive
      }
      local function mono_mode(accent)
        return {
          a = { fg = mono.bg, bg = accent, gui = "bold" },
          b = { fg = mono.fg, bg = mono.sel },
          c = { fg = mono.fg, bg = mono.c_bg },
        }
      end
      local monokai_theme = {
        normal = mono_mode(mono.green),
        insert = mono_mode(mono.blue),
        visual = mono_mode(mono.purple),
        replace = mono_mode(mono.pink),
        command = mono_mode(mono.yellow),
        inactive = {
          a = { fg = mono.dim, bg = mono.bg },
          b = { fg = mono.dim, bg = mono.bg },
          c = { fg = mono.dim, bg = mono.bg },
        },
      }

      opts.options = opts.options or {}
      opts.options.theme = monokai_theme
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }

      local s = opts.sections
      table.insert(s.lualine_x, 1, { macro, color = { fg = "#ff5f5f", gui = "bold" } })
      table.insert(s.lualine_x, { lsp_name, color = { fg = "#85b5ba" } })
      table.insert(s.lualine_z, { scrollbar, padding = { left = 0, right = 0 } })
    end,
  },
}
