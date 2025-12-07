vim.g.mapleader = ' '
-- vim.g.maplocalleader = "\\"
vim.g.c_syntax_for_h = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.guicursor = 'a:block'
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.statusline = '%f %m%r%h%w%y%q %= %l/%L:%v'
vim.o.laststatus = 3

vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open Netrw' })
vim.keymap.set('n', '<leader>n', vim.cmd.bn, { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>p', vim.cmd.bp, { desc = 'Prev Buffer' })
vim.keymap.set('n', '<leader>d', vim.cmd.bd, { desc = 'Del Buffer' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- vim-surround
-- autopairs
-- nerdcommenter
-- whichkey
-- indent-blankline
-- gitsigns
-- buffer line
-- lualine

-- find fiels, ilve_grep, help_tags, buffer, quickfix, find files, grep_string
-- vim.opt.smartcase = true
-- vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- vim.opt.shortmess:append("c")
-- vim.opt.smartindent = true
-- vim.opt.foldlevelstart = 99
-- vim.opt.wildignorecase = true
-- vim.opt.showmatch = true
-- vim.opt.ignorecase = true
-- vim.o.updatetime = 300

-- :so to source this file
-- :map jk
-- lang plugins lua, rust, etc..., (also dadbod for sql)

-- <https://github.com/ThePrimeagen/init.lua>
-- <https://github.com/SylvanFranklin/.config/tree/main/nvim>
-- <https://github.com/nvim-lua/kickstart.nvim>
-- look at my old config

require 'config.lazy'

vim.cmd.colorscheme 'gruvbox'
