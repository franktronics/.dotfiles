local function terminal_width()
  return math.min(math.floor(vim.o.columns * 0.8), 150)
end

local function terminal_height()
  return math.min(math.floor(vim.o.lines * 0.8), 62)
end

local lazygit_terminal

local function toggle_lazygit()
  local Terminal = require('toggleterm.terminal').Terminal

  if not lazygit_terminal then
    lazygit_terminal = Terminal:new {
      cmd = 'lazygit',
      direction = 'float',
      hidden = true,
      float_opts = {
        border = 'double',
        width = terminal_width,
        height = terminal_height,
      },
    }
  end

  lazygit_terminal:toggle()
end

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm direction=float<cr>', mode = { 'n', 't' }, desc = '[T]oggle floating [T]erminal' },
      { '<leader>gg', toggle_lazygit, desc = 'Open Lazy[G]it' },
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
    config = function(_, opts)
      require('toggleterm').setup(opts)
      vim.api.nvim_create_user_command('LazyGit', toggle_lazygit, { desc = 'Open LazyGit in a floating terminal' })
    end,
  },
}
