return {
  -- Colorscheme configuration
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "unokai",
      defaults = {
        lazyvim = {
          dashboard = true,
        },
      },
    },
  },


  -- Rainbow parenthesis (nvim-ts-rainbow2)
  {
    "HiPhish/nvim-ts-rainbow2",
    event = "BufReadPost",
    config = function()
      require("nvim-ts-rainbow2").setup()
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },

  -- Go to curent project pwd
  {
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },

  -- Auto save
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end,
  },

  -- Markdown preview
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },


  -- Wakatime
  {
    "wakatime/vim-wakatime",
  },

  -- Minimap (wfxr/minimap.vim)
  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap",
    init = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 0") -- Prevent auto-start
      vim.cmd("let g:minimap_auto_start_win_enter = 0") -- Prevent auto-start on win enter
    end,
    config = function()
      -- Autocmd to open minimap only for regular files, not on dashboard
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          -- Check if it's a normal file buffer and not the dashboard
          if vim.bo.buftype == "" and vim.fn.bufname("%") ~= "" and vim.fn.bufname("%") ~= "dashboard" then
            vim.cmd("MinimapOpen")
          end
        end,
      })
    end,
  },
}