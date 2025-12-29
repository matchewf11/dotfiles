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

map('<leader>n', vim.cmd.tabnew, 'Open Tab')
map('<leader>c', vim.cmd.tabclose, 'Close Tab')
map('<leader>e', vim.cmd.Ex, 'Open Netrw')
map('gl', vim.diagnostic.open_float, 'Line diagnostics')
map('<leader>d', vim.diagnostic.setloclist, 'Diagnostics in LocList')
map('<leader>y', '"+y', 'Yank Clipboard', { 'n', 'x', 'v' })
map('<leader>p', '"+p', 'Paste Clipboard', { 'n', 'x', 'v' })
map('<leader>d', '"_d', 'Delete without Cut', { 'n', 'v' })

-- vim-abolish
-- vim-swap
-- tabular
-- {'folke/which-key.nvim' }
-- { mbbill/undotree }
-- { harpoon }
-- {vim-fugitive}
-- 'chentoast/marks.nvim',
-- 'junegunn/vim-easy-align',
-- -- targets.vim
-- -- vim-sneak
-- -- leap.nvim
-- (maybe flash.nvim)
-- 'matze/vim-move',
-- 'gbprod/substitute.nvim',
-- 'AndrewRadev/splitjoin.vim',
-- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
-- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- other tpope plugins

-- :so to source this file
-- :map jk

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

-- map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitue mode in selection" })

-- Map({ "n" }, "<leader>c", "1z=")

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- KICKSTART!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- highlight same vars? (look at kickstart)

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "=ap", "ma=ap'a")
-- vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- ]b to move to next buffer
-- tabs, windows, splits, tmux, i3
--
-- gc ap (around paragragh)
-- <https://nvim-mini.org/MiniMax>
