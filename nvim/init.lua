local g, o, opt = vim.g, vim.o, vim.opt

g.mapleader = ' '
g.c_syntax_for_h = true
g.netrw_banner = false
g.netrw_list_hide = [[^\./$,^\.\./$]]

o.number = true
o.relativenumber = true
o.guicursor = ''
o.smartindent = true
o.scrolloff = 10
o.showtabline = 2
o.signcolumn = 'yes'
o.undofile = true
o.swapfile = false
o.hlsearch = false
o.updatetime = 100
o.timeoutlen = 300
o.mouse = 'a'
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
opt.path:append('**')
opt.completeopt = { 'noinsert','menuone','noselect','fuzzy' }
opt.wildoptions = { 'fuzzy' }
opt.wildmode= { 'longest:full', 'full' }
opt.wildignore = { '*/target/*' }

vim.lsp.enable { 'lua_ls', 'rust_analyzer' }

local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = '*',
  callback = function() pcall(vim.treesitter.start) end,
})

autocmd("BufWritePre", {
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

local function gh(name)
  return 'https://github.com/' .. name
end

vim.pack.add {
  gh 'bluz71/vim-moonfly-colors',
  gh 'neovim/nvim-lspconfig',
  gh 'nvim-treesitter/nvim-treesitter',
}

vim.cmd.colorscheme 'moonfly'

local function map(lhs, rhs, modes)
  vim.keymap.set(modes or 'n', lhs, rhs)
end

map('<leader>e', ':Ex<CR>')
map('<leader>t', ':tabnew<CR>')
map('<leader>x', ':tabclose<CR>')
map('<leader>y', '"+y', {'n', 'v'})
map('<leader>d', '"_d', {'n', 'v'})
map('<leader>p', '"+p')
map('<leader>c', ':!ctags -R .<cr>')
