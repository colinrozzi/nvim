# Neovim Configuration Structure

This configuration is based on kickstart.nvim but has been modularized for better organization and maintainability.

## File Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point, plugin definitions
├── lua/
│   ├── custom/
│   │   ├── base.lua           # Loads all custom modules
│   │   ├── options.lua        # Vim options and settings
│   │   ├── keymaps.lua        # Basic keymaps and bindings
│   │   ├── autocmds.lua       # Autocommands and event handlers
│   │   ├── lsp.lua            # LSP configuration and setup
│   │   ├── telescope.lua      # Telescope fuzzy finder setup
│   │   ├── treesitter.lua     # Treesitter syntax highlighting
│   │   ├── completion.lua     # nvim-cmp completion setup
│   │   └── plugins/
│   │       └── init.lua       # Custom plugin definitions
│   └── kickstart/
│       └── plugins/
│           ├── autoformat.lua # Auto-formatting plugin
│           └── debug.lua      # Debug adapter protocol
```

## Key Benefits

- **Modular**: Each major feature is in its own file
- **Maintainable**: Easy to find and modify specific configurations
- **Organized**: Related functionality is grouped together
- **Extensible**: Easy to add new modules or modify existing ones

## Main Modules

### `init.lua`
- Plugin definitions using lazy.nvim
- Calls setup functions from modular configs
- Keeps kickstart.nvim structure for easy updates

### `custom/options.lua`
- All vim options and settings
- Tab/indent configuration
- Editor behavior settings

### `custom/keymaps.lua`
- Basic key mappings
- Window navigation
- Diagnostic keymaps with clipboard integration

### `custom/lsp.lua`
- Language server configuration
- LSP keymaps and handlers
- Server-specific settings
- Diagnostic configuration

### `custom/telescope.lua`
- Fuzzy finder setup
- Search keymaps
- Telescope extensions

### `custom/treesitter.lua`
- Syntax highlighting configuration
- Text objects setup
- Incremental selection

### `custom/completion.lua`
- nvim-cmp setup
- Snippet configuration
- Completion sources

### `custom/autocmds.lua`
- Event handlers
- Auto-commands
- Highlight on yank

## Usage

The configuration loads automatically when Neovim starts. All modules are loaded in the correct order to ensure dependencies are available.

To modify specific functionality:
- **Options**: Edit `lua/custom/options.lua`
- **Keymaps**: Edit `lua/custom/keymaps.lua`
- **LSP**: Edit `lua/custom/lsp.lua`
- **Plugins**: Edit `lua/custom/plugins/init.lua`

## Adding New Modules

1. Create a new file in `lua/custom/`
2. Export a setup function: `return { setup = setup }`
3. Call the setup function in `init.lua` after plugin loading
4. Add require statement to `custom/base.lua` if needed at startup
