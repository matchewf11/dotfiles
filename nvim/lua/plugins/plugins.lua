return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        lua = { 'luacheck' }, -- luarocks
        c = { 'clangtidy' }, -- pacman
        sh = { 'shellcheck' }, -- pacman
        -- sql = { 'sqlfluff' }, -- pipx
        go = { 'golangcilint' }, -- pacman
        make = { 'checkmake' }, -- go
        rust = { 'clippy' }, -- cargo
        markdown = { 'markdownlint' }, -- npm
      }
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          lint.try_lint()
          -- lint.try_lint 'cspell' -- npm
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true }
        end,
        desc = 'Format Buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' }, -- cargo
        go = { 'gofumpt', 'goimports' }, -- go
        javascript = { 'prettier' }, -- npm
        c = { 'clang-format' }, -- pacman
        rust = { 'rustfmt' }, -- cargo
        toml = { 'taplo' }, -- cargo
        sh = { 'shfmt' }, -- pacman
        sql = { 'sqlfluff' }, -- pipx
      },
      default_format_opts = { lsp_format = 'fallback' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      for _, server in ipairs {
        'lua_ls', -- pacman
        'gopls', -- go
        'clangd', -- pacman
        'ts_ls', -- npm
        'rust_analyzer', -- rustup
        'taplo', -- cargo
        'hls', -- ghcup
        'pyright', -- npm
        -- 'sqls', -- go
        'bashls', -- pacman
      } do
        vim.lsp.enable(server)
      end
    end,
  },
}
