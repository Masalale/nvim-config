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

## Customization

LazyVim makes customization easy. You can add your own plugins, modify keybindings, and change settings by creating files in the `lua/plugins/` directory or by overriding existing configurations. Refer to the [LazyVim documentation](https://lazyvim.github.io/configuration) for more details.

## Credits

*   [LazyVim](https://github.com/LazyVim/LazyVim) - The foundation of this configuration.
*   [Neovim](https://neovim.io/) - The extensible Vim-based text editor.
