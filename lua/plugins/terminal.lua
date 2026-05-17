return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm direction=float<cr>', mode = { 'n', 't' }, desc = '[T]oggle floating [T]erminal' },
    },
    opts = {
      direction = 'float',
      start_in_insert = true,
      persist_size = true,
      float_opts = { border = 'single' },
    },
  },
}
