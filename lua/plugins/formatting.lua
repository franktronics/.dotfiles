return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local enabled_filetypes = {}
        if enabled_filetypes[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
      end,
      default_format_opts = { lsp_format = 'fallback' },
      formatters_by_ft = {},
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
