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
-- { windwp/nvim-autopairs }
-- { nvim-dap  (nvim-dap-ui), (nvim-nio), (nvim-dap-go) }
-- {'folke/which-key.nvim' }
-- { mini.nvim } stuff (surround, ai)
-- { mbbill/undotree }
-- { harpoon }
-- {vim-fugitive}
-- guess-indent
-- todo comments
-- mini.ai
-- mini.surround
-- {neotest, nvim-nio,fixcursorhold,neotest-golang,nvim-dap-go}
-- {nvim-dap, nvim-dap-ui,nvim-nio}
-- vim.pack
-- toggle term
-- comment.vim
-- vim-fugitive
-- which-key

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

--
-- ]b to move to next buffer
--
-- other tpope plugins
--
--
-- other kickstart stuff
-- other mini stuff
-- tabs, windows, splits, tmux, i3
-- add back kickstart.debug w/ config
--
-- My config ------------------------------------------------
-- local function config()
--   local servers = {
--     'rust_analyzer', -- rustup
--     'lua_ls', -- pacman
--     'gopls', -- go
--     'clangd', -- pacman
--     'taplo', -- cargo
--     'hls', -- ghcup
--     'pyright', -- npm
--     -- bash (bashls)
--     -- sql (sqlls)
--     -- json (jsonls)
--     -- docker/dockercompose? (dockerls)
--     -- cspell/textlsp/basicsls (spell-checking)
--     -- one for html/css/js/ts
--
--     -- add lsp/fmt/lint for all languages
--     -- rust
--     -- lua
--     -- go
--     -- bash
--     -- c
--     -- json
--     -- html/css/js
--     -- toml
--     -- make
--     -- haskell
--     --
--     -- markdown
--     -- yaml
--     -- docker?
--     -- sql?
--   }
--
--   local blink_abilities = require('blink.cmp').get_lsp_capabilities()
--   for _, server in ipairs(servers) do
--     vim.lsp.config(server, { capabilities = blink_abilities })
--     vim.lsp.enable(server)
--   end
-- end
--
-- return {
--   {
--     -- look into this
--     'neovim/nvim-lspconfig',
--     dependencies = { 'saghen/blink.cmp' },
--     config = config,
--     event = 'BufReadPre',
--   },
--   {
--     -- finish conform
--     'stevearc/conform.nvim',
--     lazy = true,
--     event = 'BufWritePre',
--     keys = {
--       {
--         '<leader>f',
--         function()
--           require('conform').format { lsp_format = 'fallback', async = true }
--         end,
--         desc = '[f]ormat buffer',
--       },
--     },
--     opts = {
--       notify_on_error = true,
--       format_on_save = { -- can later make fn that disables languages for this
--         timeout_ms = 500,
--         lsp_format = 'fallback', -- try use lsp if no fmter
--       },
--       formatters_by_ft = {
--         lua = { 'stylua' }, -- installed thru cargo
--         go = { 'gofumpt', 'goimports' }, -- thru go (both)
--         c = { 'clang-format' }, -- sudo pacman
--         rust = { 'rustfmt' },
--         toml = { 'taplo' },
--         --["*"] = { "codespell" },
--         --["*"] = { "trimwhitespace" },
--         --   "shfmt",         -- Shell
--         --   "sql-formatter", -- SQL
--         --   prettier?
--       },
--     },
--     -- formatters = {},
--   },
--   {
--     -- finish lint
--     'mfussenegger/nvim-lint',
--     event = { 'BufReadPre', 'BufNewFile' },
--     config = function()
--       local lint = require 'lint'
--       lint.linters_by_ft = {
--         lua = { 'luacheck' }, -- luarocks
--         go = { 'golangcilint' }, -- pacman
--         c = { 'clangtidy' },
--         make = { 'checkmake' }, -- go
--         rust = { 'clippy' },
--         --   "shellcheck",    -- Shell
--         --   shellharden
--         --   hadolint for dockerfiles
--         --   systemdlint
--         --   cspell/misspell/textlint/typos
--       }
--       local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
--       vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
--         group = lint_augroup,
--         callback = function()
--           if vim.bo.modifiable then
--             lint.try_lint()
--           end
--         end,
--       })
--     end,
--   },
--   {
--     'nvim-treesitter/nvim-treesitter',
--     branch = 'master',
--     lazy = false,
--     build = ':TSUpdate',
--     main = 'nvim-treesitter.configs',
--     opts = {
--       sync_install = false,
--       auto_install = true,
--       highlight = {
--         enable = true,
--         -- disables for large files
--         disable = function(_, buf)
--           local max_filesize = 100 * 1024 -- 100 KB
--           local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--           if ok and stats and stats.size > max_filesize then
--             return true
--           end
--         end,
--         additional_vim_regex_highlighting = regex_langs,
--       },
--       indent = {
--         enable = true,
--         disable = regex_langs,
--       },
--     },
--   },
--   -- {
--   --   'nvim-treesitter/nvim-treesitter-context',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'nvim-treesitter/nvim-treesitter-textobjects',
--   --   lazy = true,
--   -- },
--   { -- config this
--     'saghen/blink.cmp',
--     dependencies = {
--       'rafamadriz/friendly-snippets',
--       { 'L3MON4D3/LuaSnip', version = 'v2.*' },
--     },
--     version = '1.*',
--     opts = {
--       snippets = { preset = 'luasnip' },
--       keymap = { preset = 'default' },
--       appearance = {
--         nerd_font_variant = 'mono',
--       },
--       completion = { documentation = { auto_show = false } },
--       sources = {
--         default = { 'lsp', 'path', 'snippets', 'buffer' },
--       },
--       fuzzy = { implementation = 'prefer_rust_with_warning' },
--     },
--     opts_extend = { 'sources.default' },
--   },
--   {
--     'ibhagwan/fzf-lua',
--     dependencies = { 'nvim-tree/nvim-web-devicons' },
--     opts = {},
--     cmd = { 'FzfLua' },
--     keys = {
--       {
--         '<leader>sf',
--         function()
--           require('fzf-lua').files()
--         end,
--         desc = 'Search Files',
--       },
--       {
--         '<leader>sb',
--         function()
--           require('fzf-lua').buffers()
--         end,
--         desc = 'Search Buffer',
--       },
--       {
--         '<leader>sl',
--         function()
--           require('fzf-lua').blines() -- lines as well
--         end,
--         desc = 'Search Buffer Lines',
--       },
--       {
--         '<leader>so',
--         function()
--           require('fzf-lua').oldfiles()
--         end,
--         desc = 'Search Oldfiles',
--       },
--     },
--   },
--   {
--     'windwp/nvim-autopairs',
--     event = 'InsertEnter',
--     config = true,
--     -- use opts = {} for passing setup options
--     -- this is equivalent to setup({}) function
--   },
--   {
--     'lewis6991/gitsigns.nvim',
--     event = 'VeryLazy',
--   },
--   -- {
--   --   'mfussenegger/nvim-dap',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'ThePrimeagen/harpoon',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'chentoast/marks.nvim',
--   --   lazy = true,
--   -- },
--   -- {
--   --   -- Comment.nvim
--   --   'tpope/vim-commentary',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'akinsho/toggleterm.nvim',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'junegunn/vim-easy-align',
--   --   lazy = true,
--   -- },
--   -- {
--   --   -- mini.bracketed
--   --   'tpope/vim-unimpaired',
--   --   lazy = true,
--   -- },
--   -- {
--   --   -- nvim-surround
--   --   -- mini.surround
--   --   'tpope/vim-surround',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'folke/todo-comments.nvim',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'lukas-reineke/indent-blankline.nvim',
--   --   lazy = true,
--   -- },
--   -- {
--   --   -- mini.ai
--   --   -- targets.vim
--   -- },
--   -- {
--   --   -- mini.jump
--   --   -- vim-sneak
--   -- },
--   -- {
--   --   -- mini jump2d
--   --   -- leap.nvim
--   --   (maybe flash.nvim)
--   -- },
--   -- {
--   --   'matze/vim-move',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'gbprod/substitute.nvim',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'AndrewRadev/splitjoin.vim',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'akinsho/bufferline.nvim',
--   --   lazy = true,
--   -- },
--   -- {
--   --   'ntpeters/vim-better-whitespace',
--   --   lazy = true,
--   -- },
