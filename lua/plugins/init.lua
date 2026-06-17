return {
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

  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if opts.dashboard and opts.dashboard.preset and opts.dashboard.preset.keys then
        for _, key in ipairs(opts.dashboard.preset.keys) do
          if key.key == "c" then
            key.action = ":e " .. vim.fn.stdpath("config") .. "/lua/plugins/init.lua"
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

      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "c_sharp",
      },
      compile = { enabled = true },
      sync_install = true,
    },
    config = function()
      vim.env.CC = "gcc"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "rust",
        "go",
        "html",
        "css",
        "json",
        "markdown",
        "markdown_inline",
        "bash",
        "c",
        "cpp",
        "yaml",
        "toml",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },

  {
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
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
      vim.g.neominimap = {
        auto_enable = true,
        layout = "float",
        float = {
          minimap_width = 15,
          window_border = "none",
        },
        exclude_filetypes = {
          "dashboard",
          "help",
          "netrw",
          "bigfile",
          "lazy",
          "mason",
        },
        exclude_buftypes = {
          "nofile",
          "nowrite",
          "quickfix",
          "terminal",
          "prompt",
        },
        diagnostic = {
          enabled = true,
        },
        git = {
          enabled = true,
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
