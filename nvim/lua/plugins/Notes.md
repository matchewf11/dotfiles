-- return {
--   'folke/which-key.nvim',
--   event = 'VeryLazy',
--   opts = {
--     delay = 0,
--     spec = {
--       { '<leader>s', group = '[s]earch' },
--       { '<leader>g', group = '[g]it' },
--     },
--   },
-- }

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

-- rellook at all config specs for plugins (clean and look for errs)

-- add a bunch of the default keymaps of the plugins i added to the keymap file

-- get rid of defualt config if i dont change (get rid of config options to make simple)

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

-- set everyting up again

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

-- add lspconfig,then vim.lsp.enable({"lua_ls", "svelte", "rust_analyzer"})

--  learn more into mini
--  oil vs files
--  obession vs session
--  vim-startify -> starter (switched)
--  cursurword?
--  fugitive over minigit
--  gitsigns -> diff
--
--  fidget
--
-- look into packer.nvim
--
-- rustaceannvim
--
-- look at maxmini config
-- look into mini.deps and vim.pack
--
-- git workflow? how to handle merge confilcts
-- can i make a merge conflits populate my quickfix list

-- fugitive or mini.git

-- do i wanna try using debuggers again

-- finish this
return {
  -- {
  --   'nvim-mini/mini.nvim',
  --   version = false,
  --   config = function()
  --     -- require 'plugins.mini_plugs.pick' -- config this
  --     -- -- require('mini.icons').setup {} -- config this
  --     -- require('mini.snippets').setup {} -- config this
  --
  --     -- require('mini.ai').setup {} -- config this
  --     -- require('mini.diff').setup {} -- config this
  --     -- require('mini.surround').setup {} -- config this
  --     -- require('mini.comment').setup {} -- config this
  --     -- require('mini.align').setup {} -- config this
  --     -- require('mini.git').setup {} -- config this
  --     -- require('mini.extra').setup {} -- config this
  --     -- require('mini.clue').setup {} -- config this
  --     -- require('mini.bracketed').setup {}
  --     -- require('mini.bufremove').setup {}
  --     -- require('mini.completion').setup {}
  --     -- require('mini.cursorword').setup {}
  --     -- require('mini.deps').setup {}
  --     -- require('mini.docs').setup {}
  --     -- require('mini.fuzzy').setup {}
  --     -- require('mini.hipatterns').setup {}
  --     -- require('mini.indentscope').setup {}
  --     -- require('mini.jump').setup {}
  --     -- require('mini.jump2d').setup {}
  --     -- require('mini.keymap').setup {}
  --     -- require('mini.map').setup {}
  --     -- require('mini.misc').setup {}
  --     -- require('mini.move').setup {}
  --     -- require('mini.notify').setup {}
  --     -- require('mini.operators').setup {}
  --     -- require('mini.sessions').setup {}
  --     -- require('mini.splitjoin').setup {}
  --     -- require('mini.starter').setup {}
  --     -- require('mini.test').setup {}
  --     -- require('mini.tabline').setup {}
  --     -- require('mini.trailspace').setup {}
  --     -- require('mini.visits').setup {}
  --     -- require('mini.basics').setup {}
  --   end,
  -- },
}

-- config all plugins installed in lazy
-- blink with friendly snippets
