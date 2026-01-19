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
