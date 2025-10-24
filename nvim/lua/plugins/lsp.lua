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
    'rust_analyzer', -- rustup
    'lua_ls', -- pacman
    'gopls', -- go
    'clangd', -- pacman
    'taplo', -- cargo
    'zls', -- pacman
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
  },
  -- finish conform
  {
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
      },
    },
    formatters = {
      stylua = {},
      goimports = {},
      gofumpt = {},
      ['clang-format'] = {},
      rustfmt = {},
    },
  },
  -- finish lint
  {
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

-- plugins for each lang

--LSP
-- ast-grep, autotools-ls, bacon_ls, bashls, basicsls, cspell, diagnosticsls, dockercompose langauge server,
-- docker-lagnuage-server, dockerls, dprint, efm,
-- emmylua_ls, golangci-lint-langserver,
-- grammerly-langugageserver, harper-ls, ltex-ls, systemd-ls,, termux-ls, textlsp, tombi(is mine better or both)
-- C
-- debugger (more for C, C++, Rust)
-- bash-debug-dapteer, codelldb, delve, go-debug-dabter, ocamlearlybird
-- mock and local lua
-- linter
-- ast-grep, codespell, commitlint, cpplint, cspell, dotenv-linter, gitlint,
-- gospel, hadolint, misspell, revive, selene, shellcheck,
-- shellharden, semgrep, staticcheck, systemdlint, textlint, typos
-- formatter
--beautysh, crlfmt, gci, goimports-reviser, golines, go modify tages,
--gotests, luaformatter, ocaml_format, shellharden, shfmt, tombi, yamlfix, yamlfmt
-- docker
-- 'dockerls',
-- 'hadolint',
-- LSPs
--   "jsonls",        -- JSON
--   "dockerls",      -- Docker
--   "bashls",        -- Shell scripts
--   "sqlls",         -- SQL
-- Formatters
--   "shfmt",         -- Shell
--   "sql-formatter", -- SQL
-- Linters
--   "shellcheck",    -- Shell
-- Debuggers (DAP)
--   "delve",         -- Go
--   "codelldb",      -- Rust, C/C++
--   something for bash?
--   something for lua
--   capabilities = {},
--   cmd = {},
--   filetype = {},
--   settings = {},
--   look at lsp config stuff
