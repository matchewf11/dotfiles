-- add lsp/fmt/lint for all languages
-- rust
-- lua
-- go
-- bash
-- c
-- json
-- html/css/js
-- toml
-- make
-- haskell
--
-- markdown
-- yaml
-- finish this
local large_file = function(_, buf) -- disables for large files
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    return true
  end
end
local regex_langs = {}

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
    -- haskell
    'hls', -- ghcup
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
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = large_file,
        additional_vim_regex_highlighting = regex_langs,
      },
      indent = {
        enable = true,
        disable = regex_langs,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = true,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
  },
  { -- config this
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    version = '1.*',
    opts = {
      snippets = { preset = 'luasnip' },
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      {
        '<leader>sf',
        function()
          require('fzf-lua').files()
        end,
        desc = 'Search Files',
      },
      {
        '<leader>sb',
        function()
          require('fzf-lua').buffers()
        end,
        desc = 'Search Lines',
      },
      {
        '<leader>sl',
        function()
          require('fzf-lua').lines()
        end,
        desc = 'Search Lines',
      },
    },
  },
  { -- config this
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {}
    end,
  },
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == '..'
        end,
      },
    },
    keys = {
      {
        '<leader>e',
        function()
          require('oil').open()
        end,
        desc = 'Open Oil',
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = 0,
      spec = {
        { '<leader>s', group = '[s]earch' },
      },
    },
  },
  {
    'vague-theme/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'vague'
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'tpope/vim-fugitive',
    lazy = true,
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
  },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
  },
  {
    'ThePrimeagen/harpoon',
    lazy = true,
  },
  {
    'chentoast/marks.nvim',
    lazy = true,
  },
  {
    'jpalardy/vim-slime',
    lazy = true,
  },
  {
    -- require('mini.comment').setup {} -- config this
  },
  {
    -- require('mini.align').setup {} -- config this
  },
  {
    -- require('mini.extra').setup {} -- config this
  },
  {
    -- require('mini.bracketed').setup {}
  },
  {
    -- require('mini.bufremove').setup {}
  },
  {
    -- require('mini.completion').setup {}
  },
  {
    -- require('mini.cursorword').setup {}
  },
  {
    -- require('mini.deps').setup {}
  },
  {
    -- require('mini.docs').setup {}
  },
  {
    -- require('mini.surround').setup {} -- config this
  },
  {
    -- require('mini.fuzzy').setup {}
  },
  {
    -- require('mini.hipatterns').setup {}
  },
  {
    -- require('mini.indentscope').setup {}
  },
  {
    -- require('mini.ai').setup {} -- config this
  },
  {
    -- require('mini.jump').setup {}
  },
  {
    -- require('mini.jump2d').setup {}
  },
  {
    -- require('mini.keymap').setup {}
  },
  {
    -- require('mini.map').setup {}
  },
  {
    -- require('mini.misc').setup {}
  },
  {
    -- require('mini.move').setup {}
  },
  {
    -- require('mini.notify').setup {}
  },
  {
    -- require('mini.operators').setup {}
  },
  {
    -- require('mini.sessions').setup {}
  },
  {
    -- require('mini.splitjoin').setup {}
  },
  {
    -- require('mini.starter').setup {}
  },
  {
    -- require('mini.test').setup {}
  },
  {
    -- require('mini.tabline').setup {}
  },
  {
    -- require('mini.trailspace').setup {}
  },
  {
    -- require('mini.visits').setup {}
  },
  {
    -- require('mini.basics').setup {}
  },
}
