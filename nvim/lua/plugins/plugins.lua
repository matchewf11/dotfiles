return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- require('gitsigns').setup {
			--   signs = {
			--     add          = { text = '┃' },
			--     change       = { text = '┃' },
			--     delete       = { text = '_' },
			--     topdelete    = { text = '‾' },
			--     changedelete = { text = '~' },
			--     untracked    = { text = '┆' },
			--   },
			--   signs_staged = {
			--     add          = { text = '┃' },
			--     change       = { text = '┃' },
			--     delete       = { text = '_' },
			--     topdelete    = { text = '‾' },
			--     changedelete = { text = '~' },
			--     untracked    = { text = '┆' },
			--   },
			--   signs_staged_enable = true,
			--   signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
			--   numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
			--   linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
			--   word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
			--   watch_gitdir = {
			--     follow_files = true
			--   },
			--   auto_attach = true,
			--   attach_to_untracked = false,
			--   current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			--   current_line_blame_opts = {
			--     virt_text = true,
			--     virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			--     delay = 1000,
			--     ignore_whitespace = false,
			--     virt_text_priority = 100,
			--     use_focus = true,
			--   },
			--   current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
			--   sign_priority = 6,
			--   update_debounce = 100,
			--   status_formatter = nil, -- Use default
			--   max_file_length = 40000, -- Disable if file is longer than this (in lines)
			--   preview_config = {
			--     -- Options passed to nvim_open_win
			--     style = 'minimal',
			--     relative = 'cursor',
			--     row = 0,
			--     col = 1
			--   },
			-- }

			-- require('gitsigns').setup{
			--   ...
			--   on_attach = function(bufnr)
			--     local gitsigns = require('gitsigns')
			--
			--     local function map(mode, l, r, opts)
			--       opts = opts or {}
			--       opts.buffer = bufnr
			--       vim.keymap.set(mode, l, r, opts)
			--     end
			--
			--     -- Navigation
			--     map('n', ']c', function()
			--       if vim.wo.diff then
			--         vim.cmd.normal({']c', bang = true})
			--       else
			--         gitsigns.nav_hunk('next')
			--       end
			--     end)
			--
			--     map('n', '[c', function()
			--       if vim.wo.diff then
			--         vim.cmd.normal({'[c', bang = true})
			--       else
			--         gitsigns.nav_hunk('prev')
			--       end
			--     end)
			--
			--     -- Actions
			--     map('n', '<leader>hs', gitsigns.stage_hunk)
			--     map('n', '<leader>hr', gitsigns.reset_hunk)
			--
			--     map('v', '<leader>hs', function()
			--       gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			--     end)
			--
			--     map('v', '<leader>hr', function()
			--       gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			--     end)
			--
			--     map('n', '<leader>hS', gitsigns.stage_buffer)
			--     map('n', '<leader>hR', gitsigns.reset_buffer)
			--     map('n', '<leader>hp', gitsigns.preview_hunk)
			--     map('n', '<leader>hi', gitsigns.preview_hunk_inline)
			--
			--     map('n', '<leader>hb', function()
			--       gitsigns.blame_line({ full = true })
			--     end)
			--
			--     map('n', '<leader>hd', gitsigns.diffthis)
			--
			--     map('n', '<leader>hD', function()
			--       gitsigns.diffthis('~')
			--     end)
			--
			--     map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
			--     map('n', '<leader>hq', gitsigns.setqflist)
			--
			--     -- Toggles
			--     map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
			--     map('n', '<leader>tw', gitsigns.toggle_word_diff)
			--
			--     -- Text object
			--     map({'o', 'x'}, 'ih', gitsigns.select_hunk)
			--   end
			-- }
		},
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		lazy = true,
	},
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format Buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				-- configure this
				lua = { "stylua" }, -- cargo
				javascript = { "prettier" }, -- npm
				-- ["*"] = { "codespell" },
				-- ["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		opts = {
			snippets = { preset = "luasnip" },
			signature = { enabled = true },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = { enable = true },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			for _, server in ipairs({
				"lua_ls", -- pacman
				"gopls", -- go
				"clangd", -- pacman
				"ts_ls", -- npm
			}) do
				vim.lsp.enable(server)
			end
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>sb", "<CMD>FzfLua buffers<CR>", desc = "Search Buffers" },
			{ "<leader>sf", "<CMD>FzfLua files<CR>", desc = "Search Files" },
			{ "<leader>so", "<CMD>FzfLua oldfiles<CR>", desc = "Search Oldfiles" },
			{ "<leader>sl", "<CMD>FzfLua blines<CR>", desc = "Search BLines" },
		},
		cmd = { "FzfLua" },
	},
}

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
-- :Gitsigns stage_hunk
-- :Gitsigns reset_hunk
-- :Gitsigns preview_hunk_inline / preview_hunk
-- :Gitsigns nav_hunk next/prev
-- :Gitsigns blame/blame_line
-- :Gitsigns change_base <REVISION>
-- :Gitsigns diffthis <REVISION>
-- :Gitsign setqflist/setloclist (target=all/attached/[int])
-- vim.keymap.set({'o', 'x'}, 'ih', '<CMD>Gitsigns select_hunk<CR>) -- text object
-- :Gitsigns show <REVISION> to :edit current buffer at <REVISION>
