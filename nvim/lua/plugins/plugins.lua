local function map(left, right, description, modes)
  modes = modes or 'n'
  vim.keymap.set(modes, left, right, { desc = description })
end

return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      -- sa (add surround)
      -- sd (delete surround)
      -- sr (replace surround)
      -- sf/F (find surround)
      -- sh (highlight surround)
      -- sa <motion> <surround>
      -- 'f' / 't' / ()/[]/{}/<> / ? / all other chars
      require('mini.surround').setup()

      require('mini.bufremove').setup()
      map('<leader>bd', '<CMD>lua MiniBufremove.delete()<CR>', 'Delete Buffer After Unshowing')
      map('<leader>bu', '<CMD>lua MiniBufremove.unshow()<CR>', 'Unshow Buffer In All Windows')
      map('<leader>bw', '<CMD>lua MiniBufremove.unshow_in_window()<CR>', 'Unshow Only In This Window')

      -- gS (visual and normal)
      require('mini.splitjoin').setup()

      -- extends f/F/t/T to work on multiple lines
      -- repreat jump with ';'
      require('mini.jump').setup()

      -- mini.jump2d 	Jump within visible lines
      -- Enter to jump somewhere
      require('mini.jump2d').setup()

      require('mini.move').setup {
        mappings = {
          left = '<C-h>',
          right = '<C-l>',
          down = '<C-j>',
          up = '<C-k>',
          line_left = '<C-h>',
          line_right = '<C-l>',
          line_down = '<C-j>',
          line_up = '<C-k>',
        },
      }

      require('mini.icons').setup()

      require('mini.git').setup()
      map('<leader>gi', ':Git ', ':Git Init')

      -- If a line will show the history
      -- If in a diff buffer, will show in split
      map('<leader>gs', '<CMD>lua MiniGit.show_at_cursor()<CR>', 'Git Status', { 'n', 'x' })

      -- zr/zm for folding and unfolding
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'git', 'diff' },
        callback = function()
          vim.opt_local.foldmethod = 'expr'
          vim.opt_local.foldexpr = 'v:lua.MiniGit.diff_foldexpr()'
          vim.opt_local.foldlevel = 3
        end,
      })

      --  apply = 'gh', (ghip)
      --  reset = 'gH',
      --  textobject = 'gh', (dgh) (also in visual mode)
      --  goto_first = '[H',
      --  goto_prev = '[h',
      --  goto_next = ']h',
      --  goto_last = ']H',
      require('mini.diff').setup()
      map('<leader>h', '<CMD>lua MiniDiff.toggle_overlay()<CR>', 'Toggle Diff Overlay')

      local statusline = require 'mini.statusline'
      statusline.setup {
        content = {
          active = function()
            local filename = statusline.section_filename { trunc_width = 140 }
            local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
            local git = statusline.section_git { trunc_width = 40 }
            local diff = statusline.section_diff { trunc_width = 75 }
            local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
            local location = '%l/%L:%v'
            local lsp = table.concat(
              vim.tbl_map(function(client)
                return client.name
              end, vim.lsp.get_clients { bufnr = 0 }),
              ' '
            )
            return statusline.combine_groups {
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
              '%=',
              { hl = 'MiniStatuslineDevinfo', strings = { diagnostics, lsp } },
              { hl = 'MiniStatuslineFilename', strings = { location } },
            }
          end,
        },
      }

      -- If query starts with ', the match is exact.
      -- If query starts with ^, the match is exact at start.
      -- If query ends with $, the match is exact at end.
      -- If query starts with *, the match is forced to be fuzzy.

      -- caret_left = '<Left>',
      -- caret_right = '<Right>',
      -- choose = '<CR>',
      -- choose_in_split = '<C-s>',
      -- choose_in_tabpage = '<C-t>',
      -- choose_in_vsplit = '<C-v>',
      -- choose_marked = '<M-CR>',
      -- delete_char = '<BS>',
      -- delete_char_right = '<Del>',
      -- delete_left = '<C-u>',
      -- delete_word = '<C-w>',
      -- mark = '<C-x>',
      -- mark_all = '<C-a>',
      -- move_down = '<C-n>',
      -- move_start = '<C-g>',
      -- move_up = '<C-p>',
      -- paste = '<C-r>',
      -- refine = '<C-Space>',
      -- refine_marked = '<M-Space>',
      -- scroll_down = '<C-f>',
      -- scroll_left = '<C-h>',
      -- scroll_right = '<C-l>',
      -- scroll_up = '<C-b>',
      -- stop = '<Esc>',
      -- toggle_info = '<S-Tab>',
      -- toggle_preview = '<Tab>',
      require('mini.pick').setup {
        options = { use_cache = true },
        window = { prompt_caret = '█' },
      }

      map('<leader>sf', '<CMD>Pick files tool="rg"<CR>', 'Search Files')
      map('<leader>sF', '<CMD>Pick files tool="fallback"<CR>', 'Search Files Falback')

      map('<leader>sg', '<CMD>Pick grep_live<CR>', 'Search Grep')
      map('<leader>sc', '<CMD>Pick grep pattern="<cword>"<CR>', 'Search Grep Cword')
      map('<leader>sn', '<CMD>Pick grep_live globs="~/.config/nvim/"<CR>', 'Search Config')

      map('<leader>sh', '<CMD>Pick help<CR>', 'Search Help')
      map('<leader>sb', '<CMD>Pick buffers<CR>', 'Search Buffers')
      map('<leader>sr', '<CMD>Pick resume<CR>', 'Search Resume')
    end,
  },
  {
    'tpope/vim-dadbod',
    cmd = { 'DB' },
    dependencies = { 'tpope/vim-dotenv' },
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        lua = { 'luacheck' }, -- luarocks
        c = { 'clangtidy' }, -- pacman
        sh = { 'shellcheck' }, -- pacman
        sql = { 'sqlfluff' }, -- pipx
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
  { 'ellisonleao/gruvbox.nvim', priority = 1000 },
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    opts = {
      snippets = { preset = 'luasnip' },
      signature = { enabled = true },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      auto_install = true,
      highlight = { enable = true },
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
        'sqls', -- go
        'bashls', -- pacman
      } do
        vim.lsp.enable(server)
      end
    end,
  },
}

-- ]b to move to next buffer
-- tabs, windows, splits, tmux, i3
-- gc ap (around paragragh)
-- <https://nvim-mini.org/MiniMax>
-- highlight same vars? (look at kickstart)
-- try using :vimgrep and :grep
-- :map jk
-- :so to source this file

-- blink stuff
--['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
-- ['<C-e>'] = { 'hide', 'fallback' },
-- ['<C-y>'] = { 'select_and_accept', 'fallback' },
-- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
-- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
-- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
-- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
-- ['<Tab>'] = { 'snippet_forward', 'fallback' },
-- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
-- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },-
-- ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
-- ['<C-d>'] = { 'scroll_signature_down', 'fallback' },

-- mini.ai 	Extend and create a/i textobjects
-- mini.align 	Align text interactively
-- mini.completion 	Completion and signature help
-- mini.keymap 	Special key mappings
-- mini.operators 	Text edit operators
-- mini.snippets 	Manage and expand snippets

-- mini.basics 	Common configuration presets
-- mini.bracketed 	Go forward/backward with square brackets
-- mini.clue 	Show next key clues
-- mini.cmdline 	Command line tweaks
-- mini.deps 	Plugin manager
-- mini.extra 	Extra 'mini.nvim' functionality
-- mini.files 	Navigate and manipulate file system
-- mini.misc 	Miscellaneous functions
-- mini.sessions 	Session management
-- mini.visits 	Track and reuse file system visits

-- which-key
-- 'chentoast/marks.nvim',
-- `:help nvim-treesitter-incremental-selection-mod`
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--
