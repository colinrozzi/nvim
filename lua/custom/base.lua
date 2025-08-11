-- Custom base configuration
-- Load all our modular configuration

-- Load core configuration modules
require('custom.options')    -- Vim options and settings
require('custom.keymaps')    -- Basic keymaps and bindings
require('custom.autocmds')   -- Autocommands and event handlers

-- These will be called after plugins are loaded in init.lua:
-- require('custom.lsp').setup()
-- require('custom.telescope').setup()
-- require('custom.treesitter').setup() 
-- require('custom.completion').setup()
