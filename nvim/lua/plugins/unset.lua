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
    'rust_analyzer', -- rustup
    'lua_ls', -- pacman
    'gopls', -- go
    'clangd', -- pacman
    'taplo', -- cargo
    'hls', -- ghcup
    -- bash (bashls)
    -- sql (sqlls)
    -- json (jsonls)
    -- docker/dockercompose? (dockerls)
    -- cspell/textlsp/basicsls (spell-checking)
    -- one for html/css/js/ts
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
        -- disables for large files
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
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
      {
        '<leader>so',
        function()
          require('fzf-lua').oldfiles()
        end,
        desc = 'Search Oldfiles',
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
    'savq/melange-nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'melange'
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
    'lewis6991/gitsigns.nvim',
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
    -- Comment.nvim
    'tpope/vim-commentary',
    lazy = true,
  },
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
  },
  {
    'junegunn/vim-easy-align',
    lazy = true,
  },
  {
    -- mini.bracketed
    'tpope/vim-unimpaired',
    lazy = true,
  },
  {
    -- nvim-surround
    -- mini.surround
    'tpope/vim-surround',
    lazy = true,
  },
  {
    'folke/todo-comments.nvim',
    lazy = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = true,
  },
  {
    -- mini.ai
    -- targets.vim
  },
  {
    -- mini.jump
    -- vim-sneak
  },
  {
    -- mini jump2d
    -- leap.nvim
  },
  {
    'matze/vim-move',
    lazy = true,
  },
  {
    'j-hui/fidget.nvim',
    lazy = true,
  },
  {
    'gbprod/substitute.nvim',
    lazy = true,
  },
  {
    'AndrewRadev/splitjoin.vim',
    lazy = true,
  },
  {
    'akinsho/bufferline.nvim',
    lazy = true,
  },
  {
    'ntpeters/vim-better-whitespace',
    lazy = true,
  },
}

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
-- docker?
-- sql?
