vim.g.mapleader = ' ' -- vim.g.maplocalleader = "\\"
vim.g.c_syntax_for_h = true
-- vim.g.netrw_banner = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.guicursor = ''
vim.o.scrolloff = 10
vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.laststatus = 3
vim.o.showtabline = 2
vim.o.smartindent = true
vim.o.updatetime = 100

vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open Netrw' })

-- vim.keymap.set("n", "<leader>t", vim.cmd.tabnew, { desc = "Open Tab" })
-- vim.keymap.set("n", "<leader>x", vim.cmd.tabclose, { desc = "Close Tab" })

vim.keymap.set({ 'n', 'x', 'v' }, '<leader>y', '"+y')

vim.keymap.set('n', '<leader>zn', vim.cmd.term, { desc = 'Open Terminal' })
vim.keymap.set('n', '<leader>zv', function()
  vim.cmd.vs()
  vim.cmd.term()
end, { desc = 'Open Terminal in Vertical Split' })
vim.keymap.set('n', '<leader>zh', function()
  vim.cmd.sp()
  vim.cmd.term()
end, { desc = 'Open Terminal in Horiz Split' })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Line diagnostics' })

vim.keymap.set('n', '<leader>w', vim.cmd.w, { desc = 'Write Buffer' })
vim.keymap.set('n', '<leader>q', vim.cmd.q, { desc = 'Quit Buffer' })
vim.keymap.set('n', '<leader>Q', vim.cmd.Q, { desc = 'Quit and Write all Buffers' })

-- <https://www.youtube.com/watch?v=ALGBuFLzDSA>
-- vim-dadbod
-- vim-dadbod-completion
-- vim-dadbod-ui

-- vim-surround
-- autopairs
-- whichkey
-- gitsigns
-- marks.nvim
--
-- vim-abolish
-- vim-swap
-- vim-commentary
-- vim-eunuch
-- vim-sandwich
-- vim-surround
-- vim-pathogen
-- tabular

-- vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- vim.opt.shortmess:append("c")

-- look at my old config
-- :so to source this file
-- :map jk

require 'config.lazy'

-- add lsp's and diagnostics
vim.o.statusline = table.concat({
  '%f',
  '%m%r%h%w%y%q',
  "%{get(b:,'gitsigns_head','')}",
  "%{get(b:,'gitsigns_status','')}",
  '%=',
  '%l/%L:%v',
}, ' ')

vim.cmd.colorscheme 'gruvbox'

-- lsp, linter, fmt, debugger? for:
-- bash
-- lua
-- c
-- sql

-- vim.cmd [[set completeopt+=menuone,noselect,popup]]
-- require("luasnip").setup({ enable_autosnippets = true })
-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
-- map({ "n", "x" }, "<leader>d", '"+d')
-- map({ "i", "s" }, "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
-- map({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
-- map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
-- vim.cmd([[
-- 	nnoremap g= g+| " g=g=g= is less awkward than g+g+g+
-- 	nnoremap gK @='ddkPJ'<cr>| " join lines but reversed. `@=` so [count] works
-- 	xnoremap gK <esc><cmd>keeppatterns '<,'>-global/$/normal! ddpkJ<cr>
-- 	noremap! <c-r><c-d> <c-r>=strftime('%F')<cr>
-- 	noremap! <c-r><c-t> <c-r>=strftime('%T')<cr>
-- 	noremap! <c-r><c-f> <c-r>=expand('%:t')<cr>
-- 	noremap! <c-r><c-p> <c-r>=expand('%:p')<cr>
-- 	xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
-- ]])
-- for i = 1, 8 do
-- 	map({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
-- end
-- map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitue mode in selection" })
-- map({ "n" }, "<leader>g", grep)
-- map({ "n" }, "<leader>g", vimgrep)
-- map({ "n" }, "<M-n>", "<cmd>resize +2<CR>")
-- map({ "n" }, "<M-e>", "<cmd>resize -2<CR>")
-- map({ "n" }, "<M-i>", "<cmd>vertical resize +5<CR>")
-- map({ "n" }, "<M-m>", "<cmd>vertical resize -5<CR>")
-- map({ "n" }, "<leader>c", "1z=")
-- map({ "n" }, "<C-q>", ":copen<CR>", { silent = true })
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- KICKSTART!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--
-- vim.o.timeoutlen = 300
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--  NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--
-- { windwp/nvim-autopairs }
-- { nvim-dap  (nvim-dap-ui), (nvim-nio), (nvim-dap-go) }
-- { todo-comments.nvim }
-- { gitsigns.nvim }
-- { neo-tree.nvim }
-- { 'j-hui/fidget.nvim' }
-- {'folke/which-key.nvim' }
-- {'NMAC427/guess-indent.nvim' }
-- { 'lewis6991/gitsigns.nvim' },
-- { mini.nvim } stuff (surround, ai)
--
-- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
-- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
-- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--
-- highlight same vars? (look at kickstart)
--
----- vim.api.nvim_create_autocmd('TextYankPost', {
---   desc = 'Highlight when yanking (copying) text',
---   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
---   callback = function()
---     vim.hl.on_yank()
---   end,
--- })

-- ThePrimeagen -------------------------------------------------------------------------
--
-- remove whitespace
-- autocmd({"BufWritePre"}, {
--     group = ThePrimeagenGroup,
--     pattern = "*",
--     command = [[%s/\s\+$//e]],
-- })
--
-- vim.g.netrw_winsize = 25
--
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "=ap", "ma=ap'a")
-- vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
--
-- -- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])
--
-- -- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
--
-- vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
--
-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
-- vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
--
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
--
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--
-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

-- vim.opt.isfname:append("@-@")

-- { trouble.nvim }
-- { mbbill/undotree }
-- {fidget.nvim}
-- { harpoon }
-- {vim-fugitive}
-- {neotest, nvim-nio,fixcursorhold,neotest-golang,nvim-dap-go}
-- {nvim-dap, nvim-dap-ui,nvim-nio}
--
-- set up ftplugin for c, bash, lua, and sql
--
-- ]b to move to next buffer
