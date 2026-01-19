vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.c_syntax_for_h = true
vim.g.netrw_banner = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.guicursor = ''
vim.o.scrolloff = 10
vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.laststatus = 3
vim.o.showtabline = 2
vim.o.smartindent = true
vim.o.updatetime = 100

vim.opt.completeopt = { 'menuone', 'noselect', 'fuzzy' }

vim.diagnostic.config { severity_sort = true }

local function map(left, right, description, modes)
  modes = modes or 'n'
  vim.keymap.set(modes, left, right, { desc = description })
end

map('<leader>e', vim.cmd.Ex, 'Open Netrw')

map('<leader>t', vim.cmd.tabnew, 'Open Tab')
map('<leader>x', vim.cmd.tabclose, 'Close Tab')

map('gd', vim.diagnostic.open_float, 'Line diagnostics')
map('<leader>l', vim.diagnostic.setloclist, 'Diagnostics in LocList')

map('<leader>y', '"+y', 'Yank Clipboard', { 'n', 'x', 'v' })
map('<leader>p', '"+p', 'Paste Clipboard', { 'n', 'x', 'v' })
map('<leader>d', '"_d', 'Delete without Cut', { 'n', 'v' })

map('J', ":m '>+1<CR>gv=gv", 'Move Down', 'v')
map('K', ":m '<-2<CR>gv=gv", 'Move Up', 'v')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Delete Trailing Whitespace',
  group = vim.api.nvim_create_augroup('prime-delete-whitespace', {}),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

require 'config.bootstrap'

MiniDeps.now(function()
  require('mini.icons').setup()
end)

MiniDeps.now(function()
  vim.cmd.colorscheme 'miniautumn'
end)

MiniDeps.now(function()
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
end)

MiniDeps.later(function()
  require('mini.extra').setup()
end)

MiniDeps.later(function()
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
end)

MiniDeps.later(function()
  -- sa (add surround)
  -- sd (delete surround)
  -- sr (replace surround)
  -- sf/F (find surround)
  -- sh (highlight surround)
  -- sa <motion> <surround>
  -- 'f' / 't' / ()/[]/{}/<> / ? / all other chars
  require('mini.surround').setup()
end)

MiniDeps.later(function()
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
end)

MiniDeps.later(function()
  --  apply = 'gh', (ghip)
  --  reset = 'gH',
  --  textobject = 'gh', (dgh) (also in visual mode)
  --  goto_first = '[H',
  --  goto_prev = '[h',
  --  goto_next = ']h',
  --  goto_last = ']H',
  require('mini.diff').setup()
  map('<leader>h', '<CMD>lua MiniDiff.toggle_overlay()<CR>', 'Toggle Diff Overlay')
end)

MiniDeps.later(function()
  -- <C-n> in insert to fallback
  -- <C-l> to trigger completion
  -- <C-]> to fallback to vim completion
  -- <C-f> to scroll_down
  -- <C-b> to scroll_up
  require('mini.completion').setup {
    delay = { completion = math.huge, info = 25, signature = 500 },
    mappings = { force_twostep = '<C-l>', force_fallback = '<C-]>' },
  }
end)

MiniDeps.later(function()
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
end)

-- lazy load on ':DB'?
MiniDeps.later(function()
  MiniDeps.add {
    source = 'tpope/vim-dadbod',
    depends = { 'tpope/vim-dotenv' },
  }
end)

MiniDeps.later(function()
  MiniDeps.add { source = 'stevearc/conform.nvim' }
  local conform = require 'conform'
  conform.setup {
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
  }
  -- lazy load on this
  map('<leader>f', function()
    conform.format { async = true }
  end, 'Format Buffer')
end)

--   event = { 'BufReadPre', 'BufNewFile' },
MiniDeps.now(function()
  MiniDeps.add {
    source = 'neovim/nvim-lspconfig',
  }
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
end)

MiniDeps.later(function()
  --   event = { 'BufReadPost', 'BufNewFile' },
  MiniDeps.add {
    source = 'mfussenegger/nvim-lint',
  }
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
end)

-- MiniDeps.update()
-- MiniDeps.clean()
-- MiniDeps.snap_get/set/save/load()
-- MiniDeps.now/later()
-- :DepsUpdate
-- :DepsSnapSave (save state in config.path.snapshot)
-- :DepsSnapLoad (load snapshot)
-- :DepsClean
-- :DepsShowLog
-- to add
-- source
-- name (end of source by default)
-- checkout -- branch, commit
-- monitor -- track ths branch
-- depends -- array of plugin specs
-- hooks - { pre_install, post_install, pre_checkout, post_checkout }
-- -- each one {path, source, name} as an arg
-- DepsUpdate <name>
-- DepsUpdateOffline
-- DepsShowLog
-- DepsClean
-- can add ! to end of command to no-confirm
