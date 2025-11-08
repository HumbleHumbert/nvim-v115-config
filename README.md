# Neovim Configuration (nvim-v115-config)

This repository contains my personal Neovim configuration, set up with Lazy.nvim as the plugin manager. It's tailored for efficient editing, with support for LSP, autopairs, and more.

## Features
- Plugin management via [Lazy.nvim](https://github.com/folke/lazy.nvim)
- LSP setup with Mason
- Autopairs for automatic bracket completion
- Blink for enhanced navigation/search
- Quarto integration for notebook-style editing
- And other custom tweaks in `init.lua` and plugin configs

## Installation
To use this config on your machine:

1. Clone the repo into your Neovim config directory:

git clone https://github.com/HumbleHumbert/nvim-v115-config.git ~/.config/nvim

2. Launch Neovim:

uv run nvim

3. Lazy.nvim will automatically install plugins on first launch. Run `:Lazy sync` if needed.

## Plugins
- `autopairs.lua`: Auto-pairs configuration
- `blink.lua`: Blink search/navigation
- `mason-lsp.lua`: Mason for LSP servers
- `quarto.lua`: Quarto notebook support

Check `lua/plugins/` for more details.

## Customization
Feel free to fork and modify! All configs are in `lua/config/` and `lua/plugins/`.

If you encounter issues, ensure Neovim version >= 0.9 (this is based on v1.15-ish setup).
