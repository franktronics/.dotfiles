vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set({ 'n', 'i', 'x' }, '<C-s>', '<cmd>write<CR><Esc>', { desc = 'Save file' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete(0, false)
end, { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bo', '<cmd>%bdelete|edit#|bdelete#<CR>', { desc = '[B]uffer delete [O]thers' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split and show the alternate buffer in the original pane.
-- With splitright/splitbelow, the new split receives focus and keeps the current buffer.
-- The original pane switches to the previously active buffer.
local function split_with_alt(split_cmd)
  local cur_buf = vim.api.nvim_get_current_buf()
  local alt_buf = vim.fn.bufnr('#')
  local orig_win = vim.api.nvim_get_current_win()

  vim.cmd(split_cmd)
  local new_win = vim.api.nvim_get_current_win()

  local prev_buf
  if alt_buf > 0 and alt_buf ~= cur_buf and vim.fn.buflisted(alt_buf) == 1 then
    prev_buf = alt_buf
  else
    for _, b in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
      if b.bufnr ~= cur_buf then
        prev_buf = b.bufnr
        break
      end
    end
  end

  if prev_buf then
    vim.api.nvim_win_set_buf(orig_win, prev_buf)
  end
  vim.api.nvim_set_current_win(new_win)
end

vim.keymap.set('n', 'sv', function() split_with_alt 'vsplit' end, { desc = '[S]plit [V]ertical' })
vim.keymap.set('n', 'ss', function() split_with_alt 'split' end, { desc = '[S]plit horizontal' })
vim.keymap.set('n', '<leader>wq', '<C-w>q', { desc = '[W]indow [Q]uit' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = '[W]indow [O]nly' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = '[W]indow equalize' })

vim.keymap.set('n', '<leader>wH', '<cmd>vertical resize -5<CR>', { desc = '[W]indow resize left' })
vim.keymap.set('n', '<leader>wL', '<cmd>vertical resize +5<CR>', { desc = '[W]indow resize right' })
vim.keymap.set('n', '<leader>wJ', '<cmd>resize +3<CR>', { desc = '[W]indow resize down' })
vim.keymap.set('n', '<leader>wK', '<cmd>resize -3<CR>', { desc = '[W]indow resize up' })
