-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Better diagnostics display
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },

  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- Better motion/jumping
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Integrated terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 3,
        }
      })
    end
  },

  -- Better buffer closing
  {
    "moll/vim-bbye",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete Buffer" },
      { "<leader>bD", "<cmd>Bwipeout<cr>", desc = "Wipeout Buffer" },
    },
  },

  -- Git blame and history
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end,
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Git Blame Toggle" },
    },
  },

  -- Rust enhancements
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- Enable inlay hints automatically
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- Enable inlay hints if supported
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
            
            -- Rust-specific keymaps
            vim.keymap.set('n', '<leader>ra', function() vim.cmd.RustLsp('codeAction') end, 
              { desc = 'Rust Code Action', buffer = bufnr })
            vim.keymap.set('n', '<leader>rr', function() vim.cmd.RustLsp('runnables') end, 
              { desc = 'Rust Runnables', buffer = bufnr })
            vim.keymap.set('n', '<leader>rd', function() vim.cmd.RustLsp('debuggables') end, 
              { desc = 'Rust Debuggables', buffer = bufnr })
            vim.keymap.set('n', '<leader>rt', function() vim.cmd.RustLsp('testables') end, 
              { desc = 'Rust Testables', buffer = bufnr })
            vim.keymap.set('n', '<leader>rh', function() vim.cmd.RustLsp('hover', 'actions') end, 
              { desc = 'Rust Hover Actions', buffer = bufnr })
            vim.keymap.set('n', '<leader>re', function() vim.cmd.RustLsp('explainError') end, 
              { desc = 'Rust Explain Error', buffer = bufnr })
            vim.keymap.set('n', '<leader>rc', function() vim.cmd.RustLsp('openCargo') end, 
              { desc = 'Open Cargo.toml', buffer = bufnr })
            vim.keymap.set('n', '<leader>rp', function() vim.cmd.RustLsp('parentModule') end, 
              { desc = 'Go to Parent Module', buffer = bufnr })
            
            -- Toggle inlay hints
            vim.keymap.set('n', '<leader>ri', function() 
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end, { desc = 'Toggle Rust Inlay Hints', buffer = bufnr })
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust
              checkOnSave = {
                enable = true,
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              -- Enable inlay hints
              inlayHints = {
                bindingModeHints = {
                  enable = false,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                closureReturnTypeHints = {
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
      }
    end,
  },
}
