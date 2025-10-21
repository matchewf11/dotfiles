vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.o.guicursor = 'a:block'
vim.o.cursorline = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = 'a'

vim.o.breakindent = true
vim.o.signcolumn = 'yes'

vim.o.undofile = true
vim.o.updatetime = 250

vim.o.timeoutlen = 300 -- time to finish a keymap

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.scrolloff = 10

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
