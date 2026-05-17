return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle reveal<cr>', desc = 'Toggle file explorer' },
      { '\\', '<cmd>Neotree toggle reveal<cr>', desc = 'Toggle file explorer' },
    },
    init = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'NeoTreeFloatBorder', { fg = '#ffffff', bold = true })
          vim.api.nvim_set_hl(0, 'NeoTreeFloatTitle', { fg = '#ffffff', bold = true })
        end,
      })
    end,
    config = function(_, opts)
      require('neo-tree').setup(opts)
      vim.api.nvim_set_hl(0, 'NeoTreeFloatBorder', { fg = '#ffffff', bold = true })
      vim.api.nvim_set_hl(0, 'NeoTreeFloatTitle', { fg = '#ffffff', bold = true })
    end,
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
        position = 'float',
        popup = {
          border = 'double',
          size = {
            height = '80%',
            width = '45%',
          },
        },
      },
    },
  },
}
