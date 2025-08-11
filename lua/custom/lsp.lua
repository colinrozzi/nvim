-- LSP Configuration

-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Toggle inlay hints (useful for TypeScript/JavaScript)
  nmap('<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, '[T]oggle Inlay [H]ints')

  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer handled by rustaceanvim, so excluded here
  ts_ls = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }, -- TypeScript/JavaScript language server
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  cssls = {}, -- CSS language server
  jsonls = {}, -- JSON language server

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup function to be called from init.lua
local function setup()
  -- Setup neovim lua configuration
  require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      -- Skip rust_analyzer as it's handled by rustaceanvim
      if server_name == 'rust_analyzer' then
        return
      end
      
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end
  }

  -- Configure Diagnostics
  vim.diagnostic.config({
    virtual_text = {
      enabled = true,
      source = "if_many",  -- Show source if multiple sources
      prefix = "●",        -- Could also be "■", "▎", "x", etc.
      severity = nil,      -- Show all severities
      format = nil,        -- Use default formatting
    },
    signs = {
      enabled = true,
      priority = 10,
    },
    underline = {
      enabled = true,
      severity = nil,  -- Underline all severities
    },
    update_in_insert = false,  -- Don't update diagnostics while typing
    severity_sort = true,      -- Sort diagnostics by severity
    float = {
      enabled = true,
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",  -- Always show source in floating window
      header = "",
      prefix = "",
    },
  })
end

return {
  setup = setup,
  on_attach = on_attach,
  servers = servers,
}
