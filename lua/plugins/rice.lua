-- ── Rice layer: cursorline · icon glow-up · floating terminal ──

return {
  -- ═══════════════════════════════════════════════════════════════════
  -- 1.  Cursorline — built-in current-line highlight. Word-under-cursor
  --     occurrence highlighting comes from vim-illuminate (the LazyVim
  --     editor.illuminate extra): whole-word, debounced, LSP/treesitter-
  --     aware. Its IlluminatedWord* groups link to LspReference*, which
  --     unokai-reloaded.lua already styles.
  -- ═══════════════════════════════════════════════════════════════════
  {
    "cursorline",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 900,
    config = function()
      -- Subtle on unokai's #3a392f line highlight — already matches the theme.
      vim.opt.cursorline = true
      vim.opt.cursorlineopt = "line"
    end,
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- 2.  Icon glow-up — mini.icons is already installed by LazyVim.
  --     We push extra filetype mappings so you see rich icons everywhere
  --     — neo-tree, bufferline, lualine, telescope, etc.
  -- ═══════════════════════════════════════════════════════════════════
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts or {}, {
        filetype = {
          -- Languages you use
          lua = { glyph = "󰢱", hl = "MiniIconsBlue" },
          go = { glyph = "", hl = "MiniIconsCyan" },
          rust = { glyph = "󱘗", hl = "MiniIconsOrange" },
          cs = { glyph = "", hl = "MiniIconsPurple" },
          python = { glyph = "󰌠", hl = "MiniIconsYellow" },
          javascript = { glyph = "󰌞", hl = "MiniIconsYellow" },
          typescript = { glyph = "󰛦", hl = "MiniIconsBlue" },
          -- Web
          css = { glyph = "󰜘", hl = "MiniIconsBlue" },
          html = { glyph = "󰌝", hl = "MiniIconsOrange" },
          json = { glyph = "󰘦", hl = "MiniIconsYellow" },
          yaml = { glyph = "󰛫", hl = "MiniIconsCyan" },
          markdown = { glyph = "󰍔", hl = "MiniIconsBlue" },
          -- Data / infra
          sql = { glyph = "󰆼", hl = "MiniIconsBlue" },
          dockerfile = { glyph = "󰡨", hl = "MiniIconsCyan" },
          gitignore = { glyph = "󰊢", hl = "MiniIconsGrey" },
          -- Config files
          -- (match patterns aren't supported here; use the `file` table below)
        },
        file = {
          -- Exact filenames & patterns (mini.icons supports lua patterns in keys)
          [".gitignore"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
          [".env"] = { glyph = "󰒙", hl = "MiniIconsYellow" },
          [".editorconfig"] = { glyph = "󰅳", hl = "MiniIconsBlue" },
          ["Dockerfile"] = { glyph = "󰡨", hl = "MiniIconsCyan" },
          -- Catch-all for dotfiles
          ["%.dotfiles"] = { glyph = "󰒲", hl = "MiniIconsGreen" },
        },
        extension = {
          -- Additional extension overrides
          go = { glyph = "", hl = "MiniIconsCyan" },
          rs = { glyph = "󱘗", hl = "MiniIconsOrange" },
          cs = { glyph = "", hl = "MiniIconsPurple" },
          py = { glyph = "󰌠", hl = "MiniIconsYellow" },
          js = { glyph = "󰌞", hl = "MiniIconsYellow" },
          ts = { glyph = "󰛦", hl = "MiniIconsBlue" },
          jsx = { glyph = "󰌞", hl = "MiniIconsYellow" },
          tsx = { glyph = "󰛦", hl = "MiniIconsBlue" },
          lua = { glyph = "󰢱", hl = "MiniIconsBlue" },
          css = { glyph = "󰜘", hl = "MiniIconsBlue" },
          html = { glyph = "󰌝", hl = "MiniIconsOrange" },
          json = { glyph = "󰘦", hl = "MiniIconsYellow" },
          yaml = { glyph = "󰛫", hl = "MiniIconsCyan" },
          md = { glyph = "󰍔", hl = "MiniIconsBlue" },
          sql = { glyph = "󰆼", hl = "MiniIconsBlue" },
          toml = { glyph = "󰛫", hl = "MiniIconsCyan" },
          lock = { glyph = "󰌾", hl = "MiniIconsGrey" },
          -- Config / scripts
          sh = { glyph = "󰆍", hl = "MiniIconsGreen" },
          zsh = { glyph = "󰆍", hl = "MiniIconsGreen" },
          bash = { glyph = "󰆍", hl = "MiniIconsGreen" },
        },
      })
      return opts
    end,
  },

  -- ═══════════════════════════════════════════════════════════════════
  -- 3.  Floating terminal — persistent terminal toggles with state
  -- ═══════════════════════════════════════════════════════════════════
  {
    "akinsho/toggleterm.nvim",
    -- ToggleTerm registers commands only inside setup(), and it has NO
    -- plugin/ directory to do it automatically.  We use cmd = "ToggleTerm"
    -- so lazy.nvim calls setup() when :ToggleTerm is invoked.
    cmd = "ToggleTerm",
    keys = {
      -- Under <leader>T (capital) so it doesn't collide with the neotest
      -- <leader>t test prefix from the test.core extra.
      { "<leader>Tt", "<cmd>ToggleTerm direction=float<CR>", desc = "Term (float)" },
      { "<leader>Tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Term (vert)" },
      { "<leader>Th", "<cmd>ToggleTerm direction=horizontal size=12<CR>", desc = "Term (horiz)" },
      { "<C-`>", "<cmd>ToggleTerm direction=float<CR>", desc = "Term toggle" },
    },
    opts = {
      size = 12,
      open_mapping = false,
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "rounded",
        -- Use functions to compute proportional size (must return integer)
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.85)
        end,
        winblend = 3,
      },
    },
    init = function()
      vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
  },
}
