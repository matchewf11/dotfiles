-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Cursor Shape
vim.o.guicursor = 'a:block'

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"
-- vim.g.mapleader = ' '
-- vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- :so to source this file
-- fzf
-- lsp
-- <https://github.com/ThePrimeagen/init.lua>
-- <https://github.com/SylvanFranklin/.config/tree/main/nvim>
-- <https://github.com/Melkeydev/NvimConfig>
-- <https://github.com/nvim-lua/kickstart.nvim>
-- <https://github.com/alacritty/alacritty-theme/blob/master/themes/gruvbox_dark.toml>
-- look at my old config

-- load lazy and the plugins
require 'config.lazy'

vim.cmd.colorscheme 'gruvbox'
