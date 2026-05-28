vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Disable visual noise in terminal buffers',
  group = vim.api.nvim_create_augroup('terminal-tweaks', { clear = true }),
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.cursorline = false
    vim.wo.signcolumn = 'no'
    vim.wo.list = false
  end,
})
