-- Basic keymaps and key bindings

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Shortcut to refresh the current file when it's changed externally
vim.keymap.set('n', '<leader>o', ':edit<CR>', { desc = 'Refresh current file' })

-- Additional useful keymaps
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>Q', ':qa<CR>', { desc = 'Quit all' })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Enhanced diagnostic keymaps for copying
vim.keymap.set('n', '<leader>E', function()
  vim.diagnostic.open_float({
    focusable = true,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',
    prefix = ' ',
    scope = 'cursor',
  })
end, { desc = 'Open focusable diagnostic float' })

vim.keymap.set('n', '<leader>ec', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics == 0 then
    vim.notify('No diagnostics on current line', vim.log.levels.INFO)
    return
  end
  
  local messages = {}
  for _, diagnostic in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diagnostic.severity]
    table.insert(messages, string.format('[%s] %s', severity, diagnostic.message))
  end
  
  local text = table.concat(messages, '\n')
  vim.fn.setreg('+', text)
  vim.notify(string.format('Copied %d diagnostic(s) to clipboard', #diagnostics), vim.log.levels.INFO)
end, { desc = 'Copy current line diagnostics to clipboard' })

vim.keymap.set('n', '<leader>ea', function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    vim.notify('No diagnostics in current buffer', vim.log.levels.INFO)
    return
  end
  
  local messages = {}
  for _, diagnostic in ipairs(diagnostics) do
    local severity = vim.diagnostic.severity[diagnostic.severity]
    local filename = vim.fn.expand('%:t')
    table.insert(messages, string.format('%s:%d [%s] %s', filename, diagnostic.lnum + 1, severity, diagnostic.message))
  end
  
  local text = table.concat(messages, '\n')
  vim.fn.setreg('+', text)
  vim.notify(string.format('Copied %d diagnostic(s) from %s to clipboard', #diagnostics, vim.fn.expand('%:t')), vim.log.levels.INFO)
end, { desc = 'Copy all buffer diagnostics to clipboard' })
