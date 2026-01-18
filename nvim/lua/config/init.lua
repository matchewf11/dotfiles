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

map('gl', vim.diagnostic.open_float, 'Line diagnostics')
map('<leader>l', vim.diagnostic.setloclist, 'Diagnostics in LocList')

map('<leader>y', '"+y', 'Yank Clipboard', { 'n', 'x', 'v' })
map('<leader>p', '"+p', 'Paste Clipboard', { 'n', 'x', 'v' })
map('<leader>d', '"_d', 'Delete without Cut', { 'n', 'v' })

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

require 'config.lazy'

vim.cmd.colorscheme 'miniautumn'
