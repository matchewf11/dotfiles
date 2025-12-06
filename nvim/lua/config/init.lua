-- set global leader to <Space>
vim.g.mapleader = ' '
-- vim.g.maplocalleader = "\\"

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

vim.o.guicursor = 'a:block' -- Cursor Shape
vim.o.scrolloff = 8 -- how much buffer around screen

vim.keymap.set('n', '<leader>e', vim.cmd.Ex) -- Open netrw

-- :so to source this file
-- <https://github.com/ThePrimeagen/init.lua>
-- <https://github.com/SylvanFranklin/.config/tree/main/nvim>
-- <https://github.com/Melkeydev/NvimConfig>
-- <https://github.com/nvim-lua/kickstart.nvim>
-- <https://github.com/alacritty/alacritty-theme/blob/master/themes/gruvbox_dark.toml>
-- look at my old config

-- for diagnostics
-- K to look at stuff
-- vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line diagnostics" })
-- vim.o.updatetime = 300
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false })
--   end,
-- })

require 'config.lazy'

vim.cmd.colorscheme 'gruvbox'

--[[
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
colorschemes 	color schemes
awesome_colorschemes 	Awesome Neovim color schemes
highlights 	highlight groups
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
packadd 	:packadd
undotree 	history undo tree

register_ui_select 	register fzf-lua as the UI interface for vim.ui.select
deregister_ui_select 	de-register fzf-lua with vim.ui.select

dap_commands 	list,run nvim-dap builtin commands
dap_configurations 	list,run debug configurations
dap_breakpoints 	list,delete breakpoints
dap_variables 	active session variables
dap_frames 	active session jump to frame

tmux_buffers 	list tmux paste buffers

zoxide 	list recent directories

complete_path 	complete path under cursor (incl dirs)
complete_file 	complete file under cursor (excl dirs)
complete_line 	complete line (all open buffers)
complete_bline 	complete line (current buffer only)
]]

-- write custom statements?

-- blink stuff
-- C-space: Open menu or open docs if already open
-- C-n/C-p or Up/Down: Select next/previous item
-- C-e: Hide menu
-- C-k: Toggle signature help 
--
--['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
-- ['<C-e>'] = { 'hide', 'fallback' },
-- ['<C-y>'] = { 'select_and_accept', 'fallback' },
--
-- ['<Up>'] = { 'select_prev', 'fallback' },
-- ['<Down>'] = { 'select_next', 'fallback' },
-- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
-- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
--
-- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
-- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
--
-- ['<Tab>'] = { 'snippet_forward', 'fallback' },
-- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
--
-- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },-
--
-- keymap = {
--   ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
--   ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
--
--   -- default in all keymap presets
--   ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
-- }
--
--Navigation
-- j → move cursor down
-- k → move cursor up
-- Enter → open file or enter directory
-- - → go up one directory (parent of current)
-- u → go back in directory history
-- . → show hidden files
--
-- Opening files
-- o → open file in current window
-- t → open file in new tab
-- v → open file in vertical split
-- x → open file in horizontal split
--
-- File operations
-- % → create new file
-- d → delete file
-- D → create new directory
-- R → rename file
-- mf → mark file (for batch operations)
-- :Move → move marked files
-- :Copy → copy marked files
--
-- Display & sorting
-- s → change sort order (name, extension, size, time)
-- i → change listing style (thin, long, tree)
--
-- Other useful keys
-- q → quit Netrw
-- r → refresh current directory
--
-- move off of fzf-lua (can i just use :vimgrep)
