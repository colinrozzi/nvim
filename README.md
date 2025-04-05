## Overview

This configuration provides a balance of functionality and simplicity, with carefully selected plugins for a great development experience. It's designed to be:

- **Fast and responsive**: Optimized for quick startup and smooth performance
- **Modern**: LSP integration, fuzzy finding, and Git support out of the box
- **Extensible**: Easy to customize with additional plugins
- **Clean and focused**: Minimal UI with just what you need

## Key Features

- **LSP Integration**: Code intelligence with automatic server configuration
- **Fuzzy Finding**: Quick navigation with Telescope for files, buffers, and more
- **Syntax Highlighting**: Powered by Treesitter for accurate and fast highlighting
- **Git Support**: Commands and visual indicators for Git operations
- **File Navigation**: File browser with Neo-Tree (toggle with `\` key)
- **Code Completion**: Intelligent suggestions as you type
- **Auto-formatting**: Automatic code formatting on save
- **Markdown Enhancement**: Advanced editing features with Avante
- **GitHub Copilot**: AI-assisted coding integration

## Keyboard Shortcuts

### General

- `<Space>` - Leader key
- `<Space>o` - Open a file with `:e`
- `\` - Toggle file explorer (Neo-Tree)

### Navigation

- `<Space>sf` - Search files
- `<Space>sg` - Search by grep
- `<Space>?` - Find recently opened files
- `<Space><Space>` - Find existing buffers
- `<Space>/` - Fuzzy search current buffer

### LSP

- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show documentation
- `<Space>rn` - Rename
- `<Space>ca` - Code action
- `[d` / `]d` - Navigate to prev/next diagnostic
- `<Space>e` - Show diagnostic in floating window

### Git

- `<Space>gp` - Go to previous hunk
- `<Space>gn` - Go to next hunk
- `<Space>ph` - Preview hunk

## Plugin Highlights

- **lazy.nvim**: Modern plugin manager
- **nvim-lspconfig**: LSP configuration
- **telescope.nvim**: Fuzzy finder
- **treesitter**: Advanced syntax highlighting
- **neo-tree**: File explorer
- **gitsigns.nvim**: Git integration
- **nvim-cmp**: Completion engine
- **copilot.vim**: GitHub Copilot integration
- **avante.nvim**: Enhanced markdown editing
- **nvim-autopairs**: Automatic bracket pairing

## Customization

To customize this configuration:

1. Edit `init.lua` directly for small changes
2. Add new plugins in `lua/custom/plugins/*.lua`
3. Check existing keymaps with `:WhichKey`

## Acknowledgments

This configuration is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), with personal modifications to suit my workflow.
