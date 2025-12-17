vim.g.mapleader = " " -- vim.g.maplocalleader = "\\"
vim.g.c_syntax_for_h = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.guicursor = "a:block"
vim.o.scrolloff = 10
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.statusline = "%f %m%r%h%w%y%q %= %l/%L:%v"
vim.o.laststatus = 3
vim.o.showtabline = 2
vim.o.smartindent = true
vim.o.updatetime = 250 -- prime has 50

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open Netrw" })

vim.keymap.set("n", "<leader>n", vim.cmd.bn, { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>p", vim.cmd.bp, { desc = "Prev Buffer" })
vim.keymap.set("n", "<leader>d", vim.cmd.bd, { desc = "Del Buffer" })

vim.keymap.set("n", "<leader>t", vim.cmd.tabnew, { desc = "Open Tab" })
vim.keymap.set("n", "<leader>x", vim.cmd.tabclose, { desc = "Close Tab" })

vim.keymap.set("n", "<leader>v", vim.cmd.vs, { desc = "V Split" })
vim.keymap.set("n", "<leader>h", vim.cmd.sp, { desc = "H Split" })

vim.keymap.set({ "n", "x", "v" }, "<leader>y", '"+y')

vim.keymap.set("n", "<leader>zn", function()
	vim.cmd.term()
end, { desc = "Open Terminal" })
vim.keymap.set("n", "<leader>zv", function()
	vim.cmd.vs()
	vim.cmd.term()
end, { desc = "Open Terminal in Vertical Split" })
vim.keymap.set("n", "<leader>zh", function()
	vim.cmd.sp()
	vim.cmd.term()
end, { desc = "Open Terminal in Horiz Split" })

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Write Buffer" })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = "Quit Buffer" })
vim.keymap.set("n", "<leader>Q", vim.cmd.Q, { desc = "Quit and Write all Buffers" })

-- vim-surround
-- autopairs
-- whichkey
-- indent-blankline
-- gitsigns
-- marks.nvim

-- vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- vim.opt.shortmess:append("c")

-- :so to source this file
-- :map jk
-- lang plugins lua, rust, c, bash, sql, etc..., (also dadbod for sql)(i use go, js, rust alot too)
-- <https://github.com/ThePrimeagen/init.lua>
-- look at my old config

require("config.lazy")

vim.cmd.colorscheme("gruvbox")

-- set up lsp, linters, and fmt for each lang that I use

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
-- { windwp/nvim-autopairs }
-- { nvim-dap  (nvim-dap-ui), (nvim-nio), (nvim-dap-go) }
-- { todo-comments.nvim }
-- { gitsigns.nvim }
-- { indent-blankline.nvim }
-- { nvim-lint}
-- { neo-tree.nvim }
-- { 'j-hui/fidget.nvim' }
-- {'folke/which-key.nvim' }
-- {'NMAC427/guess-indent.nvim' } 
-- { 'lewis6991/gitsigns.nvim' },
-- { mini.nvim } stuff (surround, ai)
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
