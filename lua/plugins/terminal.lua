local function terminal_width()
  return math.min(math.floor(vim.o.columns * 0.8), 150)
end

local function terminal_height()
  return math.min(math.floor(vim.o.lines * 0.8), 62)
end

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
      float_opts = {
        border = 'single',
        width = terminal_width,
        height = terminal_height,
      },
    },
  },
}
