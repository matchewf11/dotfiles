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

  local mason_servers = {
    luacheck = {}, -- linter
    goimports = {}, -- fmt
    gofumpt = {}, -- fmt
    ['golangci-lint'] = {}, -- linter
    clangd = {}, -- lsp
    ['clang-format'] = {}, -- fmter
    taplo = {}, -- lsp?
    checkmake = {}, -- linter
    zls = {}, -- lsp
  }

  require('mason-tool-installer').setup {
    ensure_installed = vim.tbl_keys(mason_servers),
    auto_update = true,
  }

  local capabilities = require('blink.cmp').get_lsp_capabilities()
  require('mason-lspconfig').setup {
    auto_installation = false,
    handlers = {
      function(server_name)
        local server = mason_servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        -- call `vim.lsp.config(…)` instead of `require'lspconfig'[…]`.
        -- Change `require'lspconfig'[…]` to `vim.lsp.config(…)`.
        -- require('lspconfig')[server_name].setup(server) -- old
        vim.lsp.config(server_name, server) -- is server being read?
        -- vim.lsp.enable('foo_ls')
      end,
    },
  }

  -- vim.lsp.config['lua_ls'] = {} to config it
  -- do i need the bottom if i have this?

  vim.lsp.enable {
    'rust_analyzer', -- rustup
    'lua_ls', -- pacman
    'gopls', -- go
  }

  -- get rid of mason
  -- install it on my own
end

return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    -- lazy = true,                            -- does lazy work in this context
    -- event = { 'BufReadPre', 'BufNewFile' }, -- get rid of vary lazy?
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = config,
  },
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
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        lua = { 'luacheck' },
        go = { 'golangcilint' },
        c = { 'clangtidy' },
        make = { 'checkmake' },
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

-- config stuff that i add
-- lookm more into stuff i added
-- plugins for each lang
-- config the mason stuff and otehr tools

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
--   "rust_analyzer", -- Rust
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
--
--
--
--   capabilities = {},
--   cmd = {},
--   filetype = {},
--   settings = {},
--
--
--   look at lsp config stuff
