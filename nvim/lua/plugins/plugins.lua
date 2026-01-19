local function map(left, right, description, modes)
  modes = modes or 'n'
  vim.keymap.set(modes, left, right, { desc = description })
end

return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.extra').setup()
      require('mini.icons').setup()

      -- <C-l/h> to jump between snippets
      -- <C-j> to expand
      -- <C-n/p> to choose btwn them
      -- <C-c> to stop
      local mini_snippets = require 'mini.snippets'
      local loader = mini_snippets.gen_loader
      mini_snippets.setup {
        snippets = {
          loader.from_file '~/.config/nvim/snippets/global.lua',
          loader.from_lang(),
        },
      }

      -- <C-n> in insert to fallback
      -- <C-l> to trigger completion
      -- <C-]> to fallback to vim completion
      -- <C-f> to scroll_down
      -- <C-b> to scroll_up
      require('mini.completion').setup {
        delay = { completion = math.huge, info = 25, signature = 500 },
        mappings = { force_twostep = '<C-l>', force_fallback = '<C-]>' },
      }

      -- sa (add surround)
      -- sd (delete surround)
      -- sr (replace surround)
      -- sf/F (find surround)
      -- sh (highlight surround)
      -- sa <motion> <surround>
      -- 'f' / 't' / ()/[]/{}/<> / ? / all other chars
      require('mini.surround').setup()

      -- mini.ai 	Extend and create a/i textobjects
      --
      -- a(, a), a', a*, a<Space>, af, a?
      --
      -- read readme
      -- read docs
      -- require('mini.ai').setup(
      --   {
      --     -- Module mappings. Use `''` (empty string) to disable one.
      --     mappings = {
      --       -- Main textobject prefixes
      --       around = 'a',
      --       inside = 'i',
      --
      --       -- Next/last variants
      --       -- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
      --       -- Map LSP selection manually to use it (see `:h MiniAi.config`)
      --       around_next = 'an',
      --       inside_next = 'in',
      --       around_last = 'al',
      --       inside_last = 'il',
      --
      --       -- Move cursor to corresponding edge of `a` textobject
      --       goto_left = 'g[',
      --       goto_right = 'g]',
      --     },
      --   }
      -- )
      -- local gen_ai_spec = require('mini.extra').gen_ai_spec
      -- require('mini.ai').setup({
      --   custom_textobjects = {
      --     B = gen_ai_spec.buffer(),
      --     D = gen_ai_spec.diagnostic(),
      --     I = gen_ai_spec.indent(),
      --     L = gen_ai_spec.line(),
      --     N = gen_ai_spec.number(),
      --   },
      -- })

      require('mini.git').setup()
      map('<leader>gi', ':Git ', ':Git Init')
      map('<leader>gs', '<CMD>lua MiniGit.show_at_cursor()<CR>', 'Git Status', { 'n', 'x' })
      vim.api.nvim_create_autocmd('FileType', {
        -- zr/zm for folding and unfolding
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
              { hl = 'MiniStatuslineFilename', strings = { '%l/%L:%v' } },
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
      -- choose_marked = '<C-CR>',
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
      -- refine_marked = '<C-e>',
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
        mappings = {
          choose_marked = '<C-CR>',
          refine_marked = '<C-e>',
        },
      }

      map('<leader>sf', '<CMD>Pick files tool="rg"<CR>', 'Search Files')
      map('<leader>sF', '<CMD>Pick files tool="fallback"<CR>', 'Search Falback Files')
      map('<leader>sl', '<CMD>Pick buf_lines scope="current"<CR>', 'Search Lines Local')
      map('<leader>sL', '<CMD>Pick buf_lines scope="all"<CR>', 'Search Lines Buffers')
      map('<leader>sr', '<CMD>Pick resume<CR>', 'Search Resume')
      map('<leader>so', '<CMD>Pick oldfiles<CR>', 'Search Oldfiles')
      map('<leader>sh', '<CMD>Pick help<CR>', 'Search Help')
      map('<leader>sg', '<CMD>Pick grep_live<CR>', 'Search Grep')
      map('<leader>sw', '<CMD>Pick grep pattern="<cword>"<CR>', 'Search Cword')
      map('<leader>sb', '<CMD>Pick buffers<CR>', 'Search Buffers')
      map('<leader>sd', '<CMD>Pick diagnostics scope="current"<CR>', 'Search Diagnostics Current')
      map('<leader>sD', '<CMD>Pick diagnostics scope="all"<CR>', 'Search Diagnostics All')
      map('<leader>sk', '<CMD>Pick keymaps<CR>', 'Search Keymaps')
      map('<leader>sc', '<CMD>Pick commands<CR>', 'Search Commands')

      -- MiniExtra.pickers
      -- explorer
      -- git-branches
      -- git-commits
      -- git_files
      -- git-hunks
      -- hisotry
      -- list
      -- manpages
      -- lsp
      -- marks
      -- options
      -- registers
      -- spellsuggest
      -- treesitter
      -- visit_paths
      -- visit_labels
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
