return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = vim.fn.has 'win32' ~= 1 and 'make install_jsregexp' or nil,
    opts = {},
  },

  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'L3MON4D3/LuaSnip',
    },
    opts = {
      keymap = { preset = 'enter' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      panel = { enabled = false },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },
}
