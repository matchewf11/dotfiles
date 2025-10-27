-- add lsp/fmt/lint for all languages
-- rust
-- lua
-- go
-- bash
-- c
-- json
-- html/css/js
--
-- markdown

local function config()
  require('config.autocmds').lsp()

  vim.diagnostic.config {
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    },
  }

  local servers = {
    -- rust
    'rust_analyzer', -- rustup
    -- lua
    'lua_ls', -- pacman
    -- go
    'gopls', -- go
    -- c
    'clangd', -- pacman
    -- toml
    'taplo', -- cargo
    -- bash (bashls)
    -- sql (sqlls)
    -- json (jsonls)
    -- docker/dockercompose? (dockerls)
    -- cspell/textlsp/basicsls (spell-checking)
    -- one for html/css/js/ts
    -- what is emmylua_ls
  }

  local blink_abilities = require('blink.cmp').get_lsp_capabilities()
  for _, server in ipairs(servers) do
    vim.lsp.config(server, { capabilities = blink_abilities })
    vim.lsp.enable(server)
  end
end

return {
  {
    -- look into this
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = config,
    event = 'BufReadPre',
  },
  {
    -- finish conform
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
        lua = { 'stylua' }, -- installed thru cargo
        go = { 'gofumpt', 'goimports' }, -- thru go (both)
        c = { 'clang-format' }, -- sudo pacman
        rust = { 'rustfmt' },
        toml = { 'taplo' },
        --["*"] = { "codespell" },
        --["*"] = { "trimwhitespace" },
        --   "shfmt",         -- Shell
        --   "sql-formatter", -- SQL
        --   prettier?
      },
    },
    -- formatters = {},
  },
  {
    -- finish lint
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        lua = { 'luacheck' }, -- luarocks
        go = { 'golangcilint' }, -- pacman
        c = { 'clangtidy' },
        make = { 'checkmake' }, -- go
        rust = { 'clippy' },
        --   "shellcheck",    -- Shell
        --   shellharden
        --   hadolint for dockerfiles
        --   systemdlint
        --   cspell/misspell/textlint/typos
      }
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
