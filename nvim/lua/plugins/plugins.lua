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

      require('mini.icons').setup()

      -- -- Apply hunks inside a visual/operator region
      --  apply = 'gh', (ghip)
      --  -- Reset hunks inside a visual/operator region
      --  reset = 'gH',
      --  -- Hunk range textobject to be used inside operator
      --  -- Works also in Visual mode if mapping differs from apply and reset
      --  textobject = 'gh', (dgh)
      --  -- Go to hunk range in corresponding direction
      --  goto_first = '[H',
      --  goto_prev = '[h',
      --  goto_next = ']h',
      --  goto_last = ']H',
      require('mini.diff').setup {}

      vim.keymap.set('n', '<leader>h', MiniDiff.toggle_overlay, {
        desc = 'Toggle Diff Overlay',
      })

      require('mini.statusline').setup {
        content = {
          active = function()
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local location = '%l/%L:%v'
            local lsp = table.concat(
              vim.tbl_map(function(client)
                return client.name
              end, vim.lsp.get_clients { bufnr = 0 }),
              ' '
            )
            return MiniStatusline.combine_groups {
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
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        '[c',
        function()
          require('treesitter-context').go_to_context(vim.v.count1)
        end,
        desc = 'Jump Context',
      },
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
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-mini/mini.nvim' },
    keys = {
      { '<leader>sb', '<CMD>FzfLua buffers<CR>', desc = 'Search Buffers' },
      { '<leader>sf', '<CMD>FzfLua files<CR>', desc = 'Search Files' },
      { '<leader>so', '<CMD>FzfLua oldfiles<CR>', desc = 'Search Oldfiles' },
      { '<leader>sl', '<CMD>FzfLua blines<CR>', desc = 'Search BLines' },
    },
    cmd = { 'FzfLua' },
  },
}

-- ]b to move to next buffer
-- tabs, windows, splits, tmux, i3
-- gc ap (around paragragh)
-- <https://nvim-mini.org/MiniMax>
-- highlight same vars? (look at kickstart)
--
-- :so to source this file
-- :map jk
--
--[[
-- try using :vimgrep and :grep
quickfix 	quickfix list
quickfix_stack 	quickfix stack
loclist 	location list
loclist_stack 	location stack
lines 	open buffers lines
treesitter 	current buffer treesitter symbols
tabs 	open tabs
args 	argument list

grep 	search for a pattern with grep or rg
grep_last 	run search again with the last pattern
grep_cword 	search word under cursor
grep_cWORD 	search WORD under cursor
grep_visual 	search visual selection
grep_project 	search all project lines (fzf.vim's :Rg)
grep_curbuf 	search current buffer lines
grep_quickfix 	search the quickfix list
grep_loclist 	search the location list
lgrep_curbuf 	live grep current buffer
lgrep_quickfix 	live grep the quickfix list
lgrep_loclist 	live grep the location list
live_grep 	live grep current project
live_grep_resume 	live grep continue last search
live_grep_glob 	live_grep with rg --glob support
live_grep_native 	performant version of live_grep

tags 	search project tags
btags 	search buffer tags
tags_grep 	grep project tags
tags_grep_cword 	tags_grep word under cursor
tags_grep_cWORD 	tags_grep WORD under cursor
tags_grep_visual 	tags_grep visual selection
tags_live_grep 	live grep project tags

git_files 	git ls-files
git_status 	git status
git_diff 	git diff {ref}
git_hunks 	git hunks {ref}
git_commits 	git commit log (project)
git_bcommits 	git commit log (buffer)
git_blame 	git blame (buffer)
git_branches 	git branches
git_worktrees 	git worktrees
git_tags 	git tags
git_stash 	git stash

lsp_references 	References
lsp_definitions 	Definitions
lsp_declarations 	Declarations
lsp_typedefs 	Type Definitions
lsp_implementations 	Implementations
lsp_document_symbols 	Document Symbols
lsp_workspace_symbols 	Workspace Symbols
lsp_live_workspace_symbols 	Workspace Symbols (live query)
lsp_incoming_calls 	Incoming Calls
lsp_outgoing_calls 	Outgoing Calls
lsp_type_sub 	Sub Types
lsp_type_super 	Super Types
lsp_code_actions 	Code Actions
lsp_finder 	All LSP locations, combined view
diagnostics_document 	Document Diagnostics
diagnostics_workspace 	Workspace Diagnostics
lsp_document_diagnostics 	alias to diagnostics_document
lsp_workspace_diagnostics 	alias to diagnostics_workspace

resume 	resume last command/query
builtin 	fzf-lua builtin commands
combine 	combine different fzf-lua pickers
global 	global picker for files,buffers and symbols
profiles 	fzf-lua configuration profiles
helptags 	help tags
manpages 	man pages
commands 	neovim commands
command_history 	command history
search_history 	search history
marks 	:marks
jumps 	:jumps
changes 	:changes
registers 	:registers
tagstack 	:tags
autocmds 	:autocmd
nvim_options 	neovim options
keymaps 	key mappings
filetypes 	filetypes
menus 	menus
spellcheck 	misspelled words in buffer
spell_suggest 	spelling suggestions
undotree 	history undo tree

have a serach .config/nvim

register_ui_select 	register fzf-lua as the UI interface for vim.ui.select
deregister_ui_select 	de-register fzf-lua with vim.ui.select

complete_path 	complete path under cursor (incl dirs)
complete_file 	complete file under cursor (excl dirs)
complete_line 	complete line (all open buffers)
complete_bline 	complete line (current buffer only)
]]

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
--
-- Gitsigns
-- :Gitsigns blame/blame_line
-- :Gitsigns change_base <REVISION>
-- :Gitsign setqflist/setloclist (target=all/attached/[int])
-- vim.keymap.set({'o', 'x'}, 'ih', '<CMD>Gitsigns select_hunk<CR>) -- text object
-- :Gitsigns show <REVISION> to :edit current buffer at <REVISION>
-- :Gitsigns toggle_numhl
-- :Gitsigns toggle_linehl
-- :Gitsigns toggle_word_diff
-- :Gitsigns toggle_current_line_blame
--
-- mini.ai 	Extend and create a/i textobjects
-- mini.align 	Align text interactively
-- mini.comment 	Comment lines
-- mini.completion 	Completion and signature help
-- mini.keymap 	Special key mappings
-- mini.move 	Move any selection in any direction
-- mini.operators 	Text edit operators
-- mini.pairs 	Autopairs
-- mini.snippets 	Manage and expand snippets
-- mini.splitjoin 	Split and join arguments
--
-- mini.basics 	Common configuration presets
-- mini.bracketed 	Go forward/backward with square brackets
-- mini.bufremove 	Remove buffers
-- mini.clue 	Show next key clues
-- mini.cmdline 	Command line tweaks
-- mini.deps 	Plugin manager
-- mini.extra 	Extra 'mini.nvim' functionality
-- mini.files 	Navigate and manipulate file system
-- mini.git 	Git integration
-- mini.jump 	Jump to next/previous single character
-- mini.jump2d 	Jump within visible lines
-- mini.misc 	Miscellaneous functions
-- mini.pick 	Pick anything
-- mini.sessions 	Session management
-- mini.visits 	Track and reuse file system visits
--
-- mini.cursorword 	Autohighlight word under cursor
-- mini.hipatterns 	Highlight patterns in text
-- mini.indentscope 	Visualize and work with indent scope
-- mini.map 	Window with buffer text overview
-- mini.notify 	Show notifications
-- mini.tabline 	Tabline
-- mini.trailspace 	Trailspace (highlight and remove)
--
-- mini.doc 	Generate Neovim help files
-- mini.fuzzy 	Fuzzy matching
-- mini.test 	Test Neovim plugins
--
-- fugitive
-- which-key
--
-- 'chentoast/marks.nvim',
-- `:help nvim-treesitter-incremental-selection-mod`
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
