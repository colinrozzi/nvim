-- Autocommands and event handlers

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Markdown-specific settings
local markdown_group = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  group = markdown_group,
  callback = function()
    -- Ensure Tab behaves as normal indentation in markdown
    vim.keymap.set('i', '<Tab>', '<Tab>', { buffer = true, desc = 'Normal tab in markdown' })
    vim.keymap.set('i', '<S-Tab>', '<C-d>', { buffer = true, desc = 'Unindent in markdown' })
  end,
})

-- You can add more autocommands here as needed
-- For example:
-- 
-- Auto-resize splits when window is resized
-- vim.api.nvim_create_autocmd('VimResized', {
--   callback = function()
--     vim.cmd('wincmd =')
--   end,
-- })
--
-- Format on save for specific filetypes
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = { '*.lua', '*.rs', '*.js', '*.ts' },
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })
