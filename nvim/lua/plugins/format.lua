-- :ConformInfo -- for info
return {
  'stevearc/conform.nvim',
  lazy = true,
  event = 'BufWritePre',
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { lsp_format = 'fallback', async = true }
      end,
      desc = '[f]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = { -- can later make fn that disables languages for this
      timeout_ms = 500,
      lsp_format = 'fallback', -- try use lsp if no fmter
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt', 'goimports' },
      c = { 'clang-format' },
      rust = { 'rustfmt' },
      toml = { 'taplo' },
      --["*"] = { "codespell" },
      --["*"] = { "trimwhitespace" },
    },
  },
  formatters = {
    stylua = {},
    goimports = {},
    gofumpt = {},
    ['clang-format'] = {},
    rustfmt = {},
  },
}
