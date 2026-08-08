local function open_for_inspection(state)
  local node = state.tree:get_node()
  if not node or node.type ~= 'file' then return end

  local path = node.path or node:get_id()
  require('neo-tree.utils').open_file(state, path, node.extra and node.extra.bufnr)

  local buffer = vim.api.nvim_get_current_buf()
  vim.bo[buffer].buflisted = false
  vim.bo[buffer].bufhidden = 'wipe'
end

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
      clipboard = {
        sync = 'universal',
      },
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
            ['I'] = open_for_inspection,
            ['Y'] = function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              local cwd = vim.fn.getcwd()

              vim.ui.select({
                { label = 'Name', value = vim.fn.fnamemodify(path, ':t') },
                { label = 'Relative path', value = vim.fn.fnamemodify(path, ':~:.') },
                { label = 'Absolute path', value = path },
              }, {
                prompt = 'Copy to clipboard',
                format_item = function(item) return item.label end,
              }, function(choice)
                if not choice then return end

                local value = choice.value
                if choice.label == 'Relative path' and vim.startswith(path, cwd .. '/') then value = path:sub(#cwd + 2) end
                vim.fn.setreg('+', value)
                vim.notify('Copied: ' .. value)
              end)
            end,
          },
        },
      },
      window = {
        position = 'float',
        popup = {
          border = 'double',
          size = {
            height = '80%',
            width = '70%',
          },
        },
      },
    },
  },
}
