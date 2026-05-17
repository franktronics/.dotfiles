return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle reveal<cr>', desc = 'Toggle file explorer' },
      { '\\', '<cmd>Neotree toggle reveal<cr>', desc = 'Toggle file explorer' },
    },
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
      window = {
        width = 32,
      },
    },
  },
}
