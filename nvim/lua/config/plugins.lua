require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'kanagawa' } },
  change_detection = { notify = false },
  checker = { enabled = true, frequency = 604800 },
}

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
