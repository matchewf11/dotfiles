require('lazy').setup {
  spec = { require 'plugins' },
  -- install = { colorscheme = { 'kanagawa' } }, -- change this later?
  change_detection = { notify = false },
  checker = { enabled = true, frequency = 604800 },
}

-- opts --keycaps
-- func that changes working dir

-- minial config and plugins and keymaps and max-lazy
-- maybe use docker tools and shell and sql and other stuff

-- learn more about (config too)
--  go lsp/fmt's/linter/debugger
--  lua lsp/fmt/linter/debugger

-- look into tab feature?, also amek sure config matches (search tabs fzf, hide tabs and otehr stuff)
-- look into all my plugin configs to see if it affects anythign

--make sure to look at all plugins keymaps to write down
-- rellook at all config specs for plugins (clean and look for errs)
-- config other stuff
-- reasearch nvim basic keymaps and commands
-- config firefox as well
-- add a bunch of the default keymaps of the plugins i added to the keymap file
-- :help
-- conifg web-devicons
-- get rid of defualt config if i dont change (get rid of config options to make simple)

-- use harpoon, windows(buffers) or tabs? (or either), tabline(lualine as well)?

-- lua-dev.nvim
-- nlua.nvim (debugger)

-- i did some C stuff as well config it, and maybe debugger?
-- look into lsp stuff and debuggers for all langauges
-- ensure build tool fmting/lsp is installed
-- need pleanary.nvim for harpoon, do i config it?

-- look at my phone for notes, do i still need harpoon?
-- make marks look like harpoon?
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
--or just use harpoon
--mason auto updates
--write down all plugin keympas
--
--
-- harpoon?
-- marks plugin? marks.nvim?
-- vim.slime again?
--
-- reset everyting up
-- do i need keymaps?
-- just do :Something
--
--guess-indent
--todo comments
--mini.ai
--mini.surround
--other mini stuff
--
--treesitter (incremental selection, context, textobjects)
-- nvim -autopairs
-- nvim -dap
-- vim-line { 'markdownlint' } (look at set up in kickstart)
--
-- markview? nvim plugin
-- set up for markdown
--
-- treesitter (make a thing to fold a function)
--
-- make no changes to plugin config options or features
--
-- look at render-markdown.nvim
