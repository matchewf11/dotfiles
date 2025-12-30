vim.g.mapleader = ' '
-- vim.g.maplocalleader = "\\"

vim.g.c_syntax_for_h = true
vim.g.netrw_banner = false

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

vim.diagnostic.config { severity_sort = true }

local function map(left, right, description, modes)
  modes = modes or 'n'
  vim.keymap.set(modes, left, right, { desc = description })
end

map('<leader>e', vim.cmd.Ex, 'Open Netrw')

map('<leader>n', vim.cmd.tabnew, 'Open Tab')
map('<leader>c', vim.cmd.tabclose, 'Close Tab')

map('gl', vim.diagnostic.open_float, 'Line diagnostics')
map('<leader>d', vim.diagnostic.setloclist, 'Diagnostics in LocList')

map('<leader>y', '"+y', 'Yank Clipboard', { 'n', 'x', 'v' })
map('<leader>p', '"+p', 'Paste Clipboard', { 'n', 'x', 'v' })
map('<leader>d', '"_d', 'Delete without Cut', { 'n', 'v' })

map('<C-p>', ":m '<-2<CR>gv=gv", 'Move Line Up', 'v')
map('<C-n>', ":m '>+1<CR>gv=gv", 'Move Line Down', 'v')

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

function Diagnostics()
  local counts = vim.diagnostic.count(0)
  local letters = {
    [vim.diagnostic.severity.ERROR] = 'E',
    [vim.diagnostic.severity.WARN] = 'W',
    [vim.diagnostic.severity.INFO] = 'I',
    [vim.diagnostic.severity.HINT] = 'H',
  }

  local parts = {}
  for severity, letter in pairs(letters) do
    local n = counts[severity]
    if n and n > 0 then
      table.insert(parts, string.format('%s:%d', letter, n))
    end
  end
  return table.concat(parts, ' ')
end

function Clients()
  return table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, vim.lsp.get_clients { bufnr = 0 }),
    ' '
  )
end

vim.o.statusline = table.concat({
  '%f',
  '%m%r%h%w%y%q',
  "%{get(b:,'gitsigns_head','')}",
  "%{get(b:,'gitsigns_status','')}",
  '%=',
  '%{v:lua.Diagnostics()}',
  '%{v:lua.Clients()}',
  '%l/%L:%v',
}, ' ')

vim.cmd.colorscheme 'gruvbox'
