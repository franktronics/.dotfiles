return {
  { 'NMAC427/guess-indent.nvim', opts = {} },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local git_blame = require 'utils.git_blame'

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map('n', ']h', gitsigns.next_hunk, 'Next Git hunk')
        map('n', '[h', gitsigns.prev_hunk, 'Previous Git hunk')
        map('n', '<leader>gb', git_blame.open, 'Git blame line')
        map('n', '<leader>gB', gitsigns.toggle_current_line_blame, 'Toggle Git blame')
        map('n', '<leader>gp', gitsigns.preview_hunk, 'Preview Git hunk')
        map('n', '<leader>gs', gitsigns.stage_hunk, 'Stage Git hunk')
        map('v', '<leader>gs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Stage Git hunk')
        map('n', '<leader>gr', gitsigns.reset_hunk, 'Reset Git hunk')
        map('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Reset Git hunk')
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, 'Undo stage Git hunk')
        map('n', '<leader>gd', gitsigns.diffthis, 'Git diff file')
      end,
    },
  },

  {
    'folke/which-key.nvim',
    opts = {
      preset = 'helix',
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>g', group = '[G]it' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },

  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require('github-theme').setup(opts)
      vim.cmd.colorscheme 'github_dark_default'
    end,
  },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --       background = { -- :h background
  --         light = "latte",
  --         dark = "mocha",
  --       },
  --       transparent_background = true, -- disables setting the background color.
  --       float = {
  --         transparent = true, -- enable transparent floating windows
  --         solid = false, -- use solid styling for floating windows, see |winborder|
  --       },
  --     })
  --     vim.cmd("colorscheme catppuccin")
  --   end,
  -- },
  -- {
  --   "sainnhe/everforest",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "light"
  --     vim.g.everforest_background = "soft"
  --     vim.g.everforest_enable_italic = true
  --     vim.cmd.colorscheme("everforest")
  --   end,
  -- },
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup { mappings = { around_next = 'aa', inside_next = 'ii' }, n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },

  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          keys = {
            { icon = 'f', key = 'f', desc = 'Find file', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = 'g', key = 'g', desc = 'Find text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = 'r', key = 'r', desc = 'Recent files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = 'c', key = 'c', desc = 'Edit config', action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
            { icon = 'n', key = 'n', desc = 'New file', action = ':ene | startinsert' },
            { icon = 'q', key = 'q', desc = 'Quit', action = ':qa' },
          },
          header = [[
███████╗██████╗  █████╗ ███╗   ██╗██╗  ██╗████████╗██████╗  ██████╗ ███╗   ██╗██╗ ██████╗███████╗
██╔════╝██╔══██╗██╔══██╗████╗  ██║██║ ██╔╝╚══██╔══╝██╔══██╗██╔═══██╗████╗  ██║██║██╔════╝██╔════╝
█████╗  ██████╔╝███████║██╔██╗ ██║█████╔╝    ██║   ██████╔╝██║   ██║██╔██╗ ██║██║██║     ███████╗
██╔══╝  ██╔══██╗██╔══██║██║╚██╗██║██╔═██╗    ██║   ██╔══██╗██║   ██║██║╚██╗██║██║██║     ╚════██║
██║     ██║  ██║██║  ██║██║ ╚████║██║  ██╗   ██║   ██║  ██║╚██████╔╝██║ ╚████║██║╚██████╗███████║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝ ╚═════╝╚══════╝

  Code fast. Navigate cleanly. Stay in flow.
          ]],
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
          { section = 'startup' },
        },
      },
    },
  },

}
