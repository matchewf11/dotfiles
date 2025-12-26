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

vim.keymap.set('n', '<leader>n', vim.cmd.tabnew, { desc = 'Open Tab' })
vim.keymap.set('n', '<leader>c', vim.cmd.tabclose, { desc = 'Close Tab' })

vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open Netrw' })

vim.keymap.set({ 'n', 'x', 'v' }, '<leader>y', '"+y', {
  desc = 'Yank Clipboard',
})

vim.keymap.set({ 'n', 'x', 'v' }, '<leader>p', '"+p', {
  desc = 'Paste Clipboard',
})

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Line diagnostics' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Diagnostics in LocList' })

-- vim-surround
-- autopairs
-- whichkey
-- gitsigns
-- marks.nvim

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
--
-- map({ "n", "v", "x" }, "<C-s>", [[:s/\V]], { desc = "Enter substitue mode in selection" })
--
-- Map({ "n" }, "<leader>c", "1z=")
--
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- KICKSTART!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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
-- { neo-tree.nvim }
-- {'folke/which-key.nvim' }
-- { mini.nvim } stuff (surround, ai)

-- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
-- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
-- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--
-- highlight same vars? (look at kickstart)

-- ThePrimeagen -------------------------------------------------------------------------
--
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
-- vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- { mbbill/undotree }
-- { harpoon }
-- {vim-fugitive}
-- {neotest, nvim-nio,fixcursorhold,neotest-golang,nvim-dap-go}
-- {nvim-dap, nvim-dap-ui,nvim-nio}
--
-- ]b to move to next buffer
--
-- other tpope plugins
