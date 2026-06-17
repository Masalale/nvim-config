# My Neovim Configuration (An Opinionated LazyVim Setup)

This repository contains my personal Neovim configuration, built as an opinionated version on top of the excellent [LazyVim](https://github.com/LazyVim/LazyVim) starter.

It's tailored to my preferences for development, with a focus on C# and TypeScript/JavaScript development. Originally migrated from LunarVim, this config retains familiar keybinding patterns where possible.

## Features

- **LunarVim-style autocomplete** — `<Tab>` navigates the completion list, `<S-Tab>` navigates up, `<Enter>` accepts
- **C# development support** — OmniSharp LSP, `csharpier` formatter, .NET debugging
- **Rainbow delimiters** — Color-matched parentheses, brackets, and braces
- **Flash.nvim** — Fast buffer navigation with labels
- **Neominimap** — Sidebar minimap
- **Render-markdown** — Live markdown preview in Neovim
- **Smooth scrolling** — Enhanced `<C-u>`/`<C-d>` and scroll wheel behavior

## Installation

To set up this configuration on a new machine:

1.  **Backup any existing Neovim configuration:**
    ```bash
    mv ~/.config/nvim ~/.config/nvim_backup
    ```
2.  **Clone this repository:**
    ```bash
    git clone https://github.com/masalale/nvim-config.git ~/.config/nvim
    ```
3.  **Launch Neovim:**
    ```bash
    nvim
    ```
    Neovim will automatically install all the necessary plugins.

## Plugins

This config includes the following plugins in addition to LazyVim:

| Plugin | Description |
|--------|-------------|
| [LazyVim/LazyVim](https://github.com/LazyVim/LazyVim) | Core LazyVim distribution |
| [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) | Rainbow-colored paired delimiters |
| [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | Real-time CSS color hex highlighting |
| [ahmedkhalf/lsp-rooter.nvim](https://github.com/ahmedkhalf/lsp-rooter.nvim) | Automatic project root detection |
| [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth animated scrolling |
| [folke/flash.nvim](https://github.com/folke/flash.nvim) | Enhanced label-based buffer navigation |
| [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Live markdown rendering |
| [Isrothy/neominimap.nvim](https://github.com/Isrothy/neominimap.nvim) | Sidebar code minimap |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) | Dashboard, picker, terminal, and UI toolkit |

## Keymaps

### General
| Key | Action |
|-----|--------|
| `<Space>;` | Open dashboard |
| `<Space>/` | Toggle comment on line/selection |

### Buffer Navigation
| Key | Action |
|-----|--------|
| `<Space>bn` | Next buffer |
| `<Space>bp` | Previous buffer |
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Delete buffer |

### Flash Navigation
| Key | Action | Mode |
|-----|--------|------|
| `s` | Jump to label | Normal, Visual, Operator |
| `S` | Jump to Treesitter label | Normal, Visual, Operator |
| `r` | Remote flash | Operator |
| `R` | Treesitter search | Operator, Visual |
| `<C-s>` | Toggle flash search | Command-line |

### Minimap
| Key | Action |
|-----|--------|
| `<Space>mt` | Toggle minimap |
| `<Space>mo` | Enable minimap |
| `<Space>mc` | Disable minimap |
| `<Space>mf` | Focus minimap |

### C# Development
| Key | Action |
|-----|--------|
| `<leader>cf` | Format with csharpier |
| Standard LSP bindings | Go-to-definition, hover, rename, etc. |

## Customization

To add new plugins or override existing configurations, create files in `lua/plugins/`. The directory structure:

```
~/.config/nvim/
├── init.lua                    # Entry point (loads lazy.lua)
├── lua/
│   ├── config/
│   │   ├── lazy.lua            # lazy.nvim bootstrap and plugin spec
│   │   ├── options.lua         # Editor options
│   │   ├── keymaps.lua         # Custom keybindings
│   │   └── autocmds.lua        # Autocommands
│   └── plugins/
│       ├── init.lua            # Main plugin specs
│       ├── cmp.lua             # blink.cmp keymap overrides
│       └── example.lua         # Reference examples
├── lazy-lock.json              # Plugin version lock
└── lazyvim.json                # LazyVim install state
```

Refer to the [LazyVim documentation](https://lazyvim.github.io/configuration) for more details.

## Credits

- [LazyVim](https://github.com/LazyVim/LazyVim) — The foundation of this configuration
- [LunarVim](https://github.com/LunarVim/LunarVim) — Inspiration for the autocomplete keybindings and overall workflow
- [Neovim](https://neovim.io/) — The extensible Vim-based text editor
