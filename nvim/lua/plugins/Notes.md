-- look at the old stuff i had (look at what kickstart had)

-- get rid of status in left (use vim default)
-- get rid of mode on bottom line?

-- vim.o.laststatus = 3

-- make kepmap to move to next or prev diagnostic? '[d', '[D', ']d', ']D'
-- fugative or mini.git

key map terminal emulator and open minifiles/oil
put merge conflicts in quickfix?

-- minial config and plugins and keymaps and max-lazy
-- maybe use docker tools and shell and sql and other stuff

-- lsp/fmt/linter for
-- lua, rust, bash

-- look into tab feature?, also amek sure config matches (search tabs fzf, hide tabs and otehr stuff)

-- use harpoon, windows(buffers) or tabs? (or either), tabline(lualine as well)?

-- lua-dev.nvim
-- nlua.nvim (debugger)

-- look into lsp stuff and debuggers for all langauges
-- ensure build tool fmting/lsp is installed
-- tabs, marks, and bnext, b#/<C-^>, jump list <C-o><C-i>

-- custom marks
-- " last exited curr buffer
-- [ beginning of previsioly changed or yanked line
-- ] end of previsioly changed or yanked line
-- ^ last pos in insert mode
-- . last change in curr buffer
-- </> visual selection
-- 0 laast file edited
-- 1-9 last opened
-- also can use ' or `
-- buffers
-- b2/b3
-- b#
-- do i use tabs?
-- or just use harpoon
-- write down all plugin keympas

-- harpoon?
-- marks plugin? marks.nvim?
-- vim.slime again?

-- do i need keymaps?
-- just do :Something

--guess-indent
--todo comments
--mini.ai
--mini.surround
--other mini stuff

-- add back kickstart.debug w/ config

--treesitter (incremental selection, context, textobjects)
-- nvim -autopairs
-- nvim -dap
-- vim-line { 'markdownlint' } (look at set up in kickstart)
-- markview? nvim plugin
-- set up for markdown
-- treesitter (make a thing to fold a function)
-- make no changes to plugin config options or features
-- look at render-markdown.nvim

-- get rid of mason
-- install it on my own
-- delete wherever it downloaded the current stuff

--  learn more into mini
--  obession vs session
--  vim-startify -> starter (switched)

fugitive
gitsigns

--  fidget
--
-- look into packer.nvim
--
-- look at maxmini config
-- look into mini.deps and vim.pack
--
-- git workflow? how to handle merge confilcts
-- can i make a merge conflits populate my quickfix list


require 'plugins.mini_plugs.pick' -- config this
require('mini.icons').setup {} -- config this
require('mini.snippets').setup {} -- config this
require('mini.ai').setup {} -- config this
require('mini.diff').setup {} -- config this
require('mini.surround').setup {} -- config this
require('mini.comment').setup {} -- config this
require('mini.align').setup {} -- config this
require('mini.git').setup {} -- config this
require('mini.extra').setup {} -- config this
require('mini.clue').setup {} -- config this
require('mini.bracketed').setup {}
require('mini.bufremove').setup {}
require('mini.completion').setup {}
require('mini.cursorword').setup {}
require('mini.deps').setup {}
require('mini.docs').setup {}
require('mini.fuzzy').setup {}
require('mini.hipatterns').setup {}
require('mini.indentscope').setup {}
require('mini.jump').setup {}
require('mini.jump2d').setup {}
require('mini.keymap').setup {}
require('mini.map').setup {}
require('mini.misc').setup {}
require('mini.move').setup {}
require('mini.notify').setup {}
require('mini.operators').setup {}
require('mini.sessions').setup {}
require('mini.splitjoin').setup {}
require('mini.starter').setup {}
require('mini.test').setup {}
require('mini.tabline').setup {}
require('mini.trailspace').setup {}
require('mini.visits').setup {}
require('mini.basics').setup {}

-- config all plugins installed in lazy
-- blink with friendly snippets
  -- haskell stuff

<https://github.com/SylvanFranklin/.config/tree/main/nvim>
<https://github.com/Melkeydev/NvimConfig>
<https://github.com/ThePrimeagen/init.lua/tree/master/lua/theprimeagen/lazy>

-- do i wanna try using debuggers again
