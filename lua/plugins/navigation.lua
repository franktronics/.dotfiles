return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        char = {
          keys = { 'f' },
          jump_labels = true,
        },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    },
    config = function()
      local telescope = require 'telescope'
      telescope.setup {
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch recent files' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', function()
        builtin.buffers { initial_mode = 'normal' }
      end, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
      end, { desc = 'Fuzzy search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
      end, { desc = '[S]earch in open files' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          vim.keymap.set('n', 'gd', function()
            builtin.lsp_definitions { reuse_win = true }
          end, { buffer = buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences', nowait = true })
          vim.keymap.set('n', 'gI', function()
            builtin.lsp_implementations { reuse_win = true }
          end, { buffer = buf, desc = '[G]oto [I]mplementation' })
          vim.keymap.set('n', 'gy', function()
            builtin.lsp_type_definitions { reuse_win = true }
          end, { buffer = buf, desc = '[G]oto T[y]pe Definition' })
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open document symbols' })
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open workspace symbols' })
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })

          for _, client in ipairs(vim.lsp.get_clients { bufnr = buf }) do
            if client.name == 'vtsls' then
              vim.keymap.set('n', 'gD', function()
                local win = vim.api.nvim_get_current_win()
                local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
                client:exec_cmd({
                  command = 'typescript.goToSourceDefinition',
                  arguments = { params.textDocument.uri, params.position },
                }, { bufnr = buf }, function(err, result)
                  if err then
                    vim.notify('Go to source definition failed: ' .. err.message, vim.log.levels.ERROR)
                    return
                  end
                  if not result or vim.tbl_isempty(result) then
                    vim.notify('No source definition found', vim.log.levels.INFO)
                    return
                  end
                  vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
                end)
              end, { buffer = buf, desc = '[G]oto Source [D]efinition' })
              break
            end
          end
        end,
      })
    end,
  },

  { 'christoomey/vim-tmux-navigator' },
}
