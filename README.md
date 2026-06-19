# 🚀 nvim-config

My Neovim setup — a [LazyVim](https://github.com/LazyVim/LazyVim) base with the opinions cranked up. Built for living in **C#** and **TypeScript/JavaScript**, with muscle memory carried over from my LunarVim days.

Fast, quiet, and it gets out of the way. That's the whole pitch.

```
┌─ monokai theme · split minimap · save-as-you-type ────┐
│  treesitter everything · flash jumps · rainbow that   │
│  actually matches your colorscheme                    │
└───────────────────────────────────────────────────────┘
```

> **Requires** Neovim **0.11+** (built on 0.12). Treesitter runs on the new `main` branch, so a recent build matters.

## ✨ The good stuff

- **⌨️ Completion that feels like home** — `<Tab>` walks the menu, `<S-Tab>` walks back, `<Enter>` accepts. Pure LunarVim reflexes, zero relearning.
- **💾 Never lose work** — auto-save writes to disk on `InsertLeave` and (debounced) as you type, silently and without ever reformatting under you. The formatter only runs on a deliberate `:w` / `<leader>cf`, so it can't reflow code mid-edit.
- **🟣 C# as a first-class citizen** — the **Roslyn** language server (the engine behind VS Code's C# Dev Kit) via `roslyn.nvim` for rock-solid IntelliSense, plus `csharpier` formatting and `netcoredbg` debugging — all wired up out of the box.
- **🖌️ Custom Monokai** — a contrast-tuned (WCAG-AA) take on the classic VS Code Monokai, shipped as a real colorscheme you can preview and pick from `<leader>uC`. Floats and popups themed to match.
- **🌈 Rainbow brackets that read the room** — delimiter colors are pulled from your *active* colorscheme and re-derive on every theme switch. No more One-Dark brackets fighting a Monokai background.
- **⚡ Flash jumps** — hit `s`, type two chars, teleport. `S` does the same on Treesitter nodes.
- **🗺️ Split minimap** — Neominimap in a split (only for real code buffers — never the dashboard or file trees), with diagnostics, git changes, and treesitter highlights baked in.
- **📝 Live markdown** — render-markdown turns your `.md` buffers into something readable in place.
- **🎨 Inline color swatches** — colorizer paints hex/rgb/hsl right in CSS, SCSS, HTML & JS (lazy-loaded, so it costs nothing until you open one).
- **🛹 Buttery scrolling** — neoscroll animates `<C-u>` / `<C-d>` and friends.

## 📦 Getting it running

```bash
# stash whatever you've got
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# grab this
git clone git@github.com:Masalale/nvim-config.git ~/.config/nvim

# launch — plugins install themselves on first run
nvim
```

First boot pulls every plugin and compiles treesitter parsers, so give it a minute. After that, you're flying.

## 🧩 What's bolted on

On top of LazyVim's defaults:

| Plugin | What it does |
|--------|--------------|
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Dashboard, pickers, UI bits — the LazyVim Swiss army knife |
| [rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) | Theme-aware rainbow brackets |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Parsing + highlight, with extra parsers for C#, C++, CSS, Go & Rust |
| [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua) | Inline color previews (the maintained `catgoose` fork) |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth animated scrolling |
| [flash.nvim](https://github.com/folke/flash.nvim) | Label-based jump navigation |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | In-buffer markdown rendering |
| [neominimap.nvim](https://github.com/Isrothy/neominimap.nvim) | Split code minimap (code buffers only) |
| [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) | Roslyn C# language server — the VS Code C# Dev Kit engine |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating / split terminals under `<leader>T` |

C# tooling — the **Roslyn** LSP (`roslyn.nvim`), `csharpier` formatting, and `netcoredbg` debugging — rides on `mason.nvim` and `conform.nvim`. The Roslyn server installs through mason (the [Crashdummyy registry](https://github.com/Crashdummyy/mason-registry) is added so you get current, C# 14-ready builds). Project root detection is LazyVim's built-in logic — no extra plugin needed.

## ⌨️ Keymaps worth knowing

`<leader>` is `<Space>`.

**General**
| Key | Does |
|-----|------|
| `<Space>;` | Open the dashboard |
| `<Space>/` | Toggle comment (line or selection) |

**Buffers**
| Key | Does |
|-----|------|
| `<Space>bj` | Pick a buffer to jump to |
| `<Space>bn` / `<Space>bp` | Next / previous buffer |
| `<S-l>` / `<S-h>` | Next / previous buffer |
| `<leader>bd` | Close buffer |

**Flash**
| Key | Does | Modes |
|-----|------|-------|
| `s` | Jump to label | normal, visual, operator |
| `S` | Jump to Treesitter node | normal, visual, operator |
| `r` | Remote flash | operator |
| `R` | Treesitter search | operator, visual |
| `<C-s>` | Toggle flash in search | command-line |

**Minimap**
| Key | Does |
|-----|------|
| `<Space>mt` | Toggle |
| `<Space>mo` / `<Space>mc` | Open / close |
| `<Space>mf` | Focus the minimap window |

**Terminal** (toggleterm)
| Key | Does |
|-----|------|
| `<Space>Tt` | Floating terminal |
| `<Space>Tv` / `<Space>Th` | Vertical / horizontal split terminal |
| `<Esc><Esc>` | Exit terminal mode (back to normal) |

**C#** — `<leader>cf` formats with csharpier; Roslyn powers the usual LSP bindings — go-to-definition, hover, rename (`<leader>cr`), and code actions / refactors (`<leader>ca`) — everywhere.

## 🛠️ Making it yours

Drop new specs into `lua/plugins/` — every `.lua` file in there loads automatically. Handy shortcut: from the dashboard, press **`c`** to open a picker of your `plugins/` files.

```
~/.config/nvim/
├── init.lua                  # entry point
├── colors/
│   └── monokai.lua           # custom contrast-tuned Monokai colorscheme
├── lua/
│   ├── config/
│   │   ├── lazy.lua          # lazy.nvim bootstrap + plugin spec
│   │   ├── options.lua       # editor options
│   │   ├── keymaps.lua       # custom keys
│   │   └── autocmds.lua      # auto-save (formatter only on manual save)
│   └── plugins/
│       ├── init.lua          # core specs: treesitter, C#/Roslyn, minimap…
│       ├── ui.lua            # bufferline + lualine (Monokai theme)
│       ├── rice.lua          # mini.icons + floating terminal
│       ├── neo-tree.lua      # file explorer styling
│       ├── dap.lua           # C# debugging (netcoredbg)
│       ├── neotest.lua       # C# test running
│       ├── cmp.lua           # blink.cmp keymap overrides
│       └── example.lua       # LazyVim's reference examples
├── lazy-lock.json            # version lockfile
└── lazyvim.json              # LazyVim install state
```

The [LazyVim docs](https://lazyvim.github.io/configuration) cover everything else.

## 🙏 Standing on shoulders

- [LazyVim](https://github.com/LazyVim/LazyVim) — the foundation
- [LunarVim](https://github.com/LunarVim/LunarVim) — where the muscle memory came from
- [Neovim](https://neovim.io/) — the editor that makes all of this possible
