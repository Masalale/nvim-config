# My Neovim Configuration (An Opinionated LazyVim Setup)

This repository contains my personal Neovim configuration, built as an opinionated version on top of the excellent [LazyVim](https://github.com/LazyVim/LazyVim) starter.

It's tailored to my preferences for development, including custom plugins, keybindings, and aesthetic choices.

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

- [LazyVim/LazyVim](https://github.com/LazyVim/LazyVim) – Core configuration
- [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) – Rainbow parentheses
- [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) – CSS color highlighting
- [ahmedkhalf/lsp-rooter.nvim](https://github.com/ahmedkhalf/lsp-rooter.nvim) – Project root detection
- [Pocco81/auto-save.nvim](https://github.com/Pocco81/auto-save.nvim) – Auto-save files
- [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) – Smooth scrolling
- [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) – Markdown preview
- [wakatime/vim-wakatime](https://github.com/wakatime/vim-wakatime) – Coding time tracking
- [Isrothy/neominimap.nvim](https://github.com/Isrothy/neominimap.nvim) – Minimap sidebar
- [folke/snacks.nvim](https://github.com/folke/snacks.nvim) – Dashboard and UI enhancements (used for the default LazyVim dashboard)

## Keymaps

- `<Space>;` – Open the LazyVim dashboard at any time (powered by Snacks.nvim)
- `<Space>bj` – Jump to buffer (LunarVim-style buffer switcher with letter highlighting)
- `<Space>bn` / `<Space>bp` – Next/previous buffer
- `<Space>mt` – Toggle minimap
- `<Space>mo` / `<Space>mc` – Open/close minimap

## Customization

LazyVim makes customization easy. You can add your own plugins, modify keybindings, and change settings by creating files in the `lua/plugins/` directory or by overriding existing configurations. Refer to the [LazyVim documentation](https://lazyvim.github.io/configuration) for more details.

## Credits

*   [LazyVim](https://github.com/LazyVim/LazyVim) - The foundation of this configuration.
*   [Neovim](https://neovim.io/) - The extensible Vim-based text editor.
