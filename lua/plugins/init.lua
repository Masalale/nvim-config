return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai",
      defaults = {
        lazyvim = {
          dashboard = true,
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if opts.dashboard and opts.dashboard.preset and opts.dashboard.preset.keys then
        for _, key in ipairs(opts.dashboard.preset.keys) do
          if key.key == "c" then
            key.desc = "Plugins"
            key.action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') .. '/lua/plugins' })"
            break
          end
        end
      end
    end,
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }

      -- Bracket colors follow the active colorscheme: take the foreground of a
      -- curated set of highlight groups, refreshed on every ColorScheme change.
      -- Falls back to fixed hex if a source group has no foreground.
      local sources = {
        RainbowDelimiterRed = { "@constant.builtin", "Error", "#E06C75" },
        RainbowDelimiterYellow = { "@function", "WarningMsg", "#E5C07B" },
        RainbowDelimiterBlue = { "@keyword", "Function", "#61AFEF" },
        RainbowDelimiterOrange = { "@number", "Constant", "#D19A66" },
        RainbowDelimiterGreen = { "@string", "String", "#98C379" },
        RainbowDelimiterViolet = { "@type", "Type", "#C678DD" },
        RainbowDelimiterCyan = { "@property", "Special", "#56B6C2" },
      }

      local function fg_of(name)
        local ok, h = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
        return ok and h.fg and string.format("#%06x", h.fg) or nil
      end

      local function apply()
        for group, src in pairs(sources) do
          vim.api.nvim_set_hl(0, group, { fg = fg_of(src[1]) or fg_of(src[2]) or src[3] })
        end
      end

      apply()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("RainbowDelimiterColors", { clear = true }),
        callback = apply,
      })
    end,
  },

  -- Treesitter (LazyVim drives the `main` branch). LazyVim already enables
  -- highlight/indent/folds and installs a broad default parser set, and
  -- declares `opts_extend = { "ensure_installed" }`, so this list is appended,
  -- not replaced — only name the parsers LazyVim's defaults lack.
  -- Don't set `config`/`build` here: those are last-wins (not merged) and would
  -- clobber LazyVim's main-branch setup. `$CC` goes in `init` so it's set
  -- before the build step; the parser-compiling `cc` crate respects it.
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.env.CC = "gcc"
    end,
    opts = {
      ensure_installed = { "c_sharp", "cpp", "css", "go", "rust" },
    },
  },

  -- Maintained fork of the (archived) norcalli colorizer. Lazy-loads on the
  -- highlighted filetypes instead of at startup.
  {
    "catgoose/nvim-colorizer.lua",
    ft = { "css", "scss", "html", "javascript" },
    main = "colorizer",
    opts = {
      filetypes = { "css", "scss", "html", "javascript" },
      options = {
        parsers = {
          css = true, -- preset: names, hex, rgb, hsl, oklch, css_var
          css_fn = true, -- preset: rgb()/hsl()/oklch() functions
          hex = { rrggbbaa = true }, -- also #RRGGBBAA (rgb/rrggbb on by default)
        },
      },
    },
  },

  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      })
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    opts = {},
  },

  -- {
  --   "wakatime/vim-wakatime",
  -- },

  {
    "Isrothy/neominimap.nvim",
    version = "v3.*.*",
    enabled = true,
    lazy = false,
    init = function()
      -- A "code" buffer = a real, on-disk file: not the dashboard, neo-tree,
      -- a terminal, a directory listing (nvim <dir>), or any unnamed/special
      -- buffer.
      local function is_code_buf(bufnr)
        if vim.bo[bufnr].buftype ~= "" then
          return false
        end
        local name = vim.api.nvim_buf_get_name(bufnr)
        return name ~= "" and vim.fn.isdirectory(name) == 0
      end

      vim.g.neominimap = {
        auto_enable = true,
        -- Gate minimap *generation* to code buffers (the exclude_* lists below
        -- are now just belt-and-suspenders).
        buf_filter = is_code_buf,
        -- In split layout the minimap pane opens per-TAB and is NOT gated by
        -- buf_filter: should_show_minimap_for_tab only checks the tab is
        -- enabled, so an empty pane lingers on the dashboard. tab_filter is the
        -- per-tab gate — show the split only when the tab holds a code window.
        tab_filter = function(tabid)
          for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabid)) do
            if vim.api.nvim_win_is_valid(winid) and is_code_buf(vim.api.nvim_win_get_buf(winid)) then
              return true
            end
          end
          return false
        end,
        -- Split layout (not float): a float renders *over* the window without
        -- reserving space, so long lines hide underneath it. A split reserves
        -- real estate on the right, so text stays in the narrower editing
        -- window and wraps to the next line (see wrap in config/options.lua).
        layout = "split",
        split = {
          -- 15 cols ≈ 160px — matches the minimap render width so the split
          -- hugs the minimap instead of reserving a wider gutter (20 ≈ 215px).
          minimap_width = 15,
          fix_width = true,
          direction = "right",
          close_if_last_window = true,
        },
        -- buf_filter already rejects every non-file buffer, so the only
        -- filetype worth excluding is bigfile — a real on-disk file (buftype
        -- "") that buf_filter would otherwise accept; skip it for performance.
        exclude_filetypes = { "bigfile" },
        -- Remove the (now empty) signcolumn so the minimap glyphs span the
        -- full window width — no inner gutter between content and border.
        winopt = function(opt)
          opt.signcolumn = "no"
        end,
        diagnostic = {
          enabled = true,
        },
        git = {
          -- "line" not "sign": git signs need a signcolumn gutter, which ate
          -- ~55px inside the window (content 110px vs window 165px). Line mode
          -- highlights the minimap rows instead — git stays visible and the
          -- glyphs fill the full width.
          enabled = true,
          mode = "line",
        },
        treesitter = {
          enabled = true,
        },
      }
    end,
    keys = {
      { "<leader>mt", "<cmd>Neominimap toggle<CR>", desc = "Toggle minimap" },
      { "<leader>mo", "<cmd>Neominimap on<CR>", desc = "Open minimap" },
      { "<leader>mc", "<cmd>Neominimap off<CR>", desc = "Close minimap" },
      { "<leader>mf", "<cmd>Neominimap focus<CR>", desc = "Focus minimap" },
    },
  },

  -- C# LSP (no F#)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },

  -- Mason: C# only (no F#)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "csharpier", "netcoredbg" },
    },
  },

  -- C# formatting via csharpier (replaces LSP fallback)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },
}
