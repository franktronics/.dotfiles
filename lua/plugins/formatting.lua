return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local enabled_filetypes = {
          c = true,
          cpp = true,
          css = true,
          html = true,
          javascript = true,
          javascriptreact = true,
          json = true,
          jsonc = true,
          lua = true,
          markdown = true,
          scss = true,
          sh = true,
          typescript = true,
          typescriptreact = true,
          yaml = true,
        }
        if enabled_filetypes[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
      end,
      default_format_opts = { lsp_format = 'fallback' },
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        css = { 'prettier' },
        html = { 'prettier' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        scss = { 'prettier' },
        sh = { 'shfmt' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        yaml = { 'prettier' },
      },
    },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true } end,
        mode = { 'n', 'v' },
        desc = '[F]ormat buffer',
      },
    },
  },
}
