return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup {} -- config this
    require('mini.diff').setup {} -- config this
    require('mini.surround').setup {} -- config this
    require('mini.comment').setup {} -- config this
    require('mini.align').setup {} -- config this
    require('mini.statusline').setup {} -- config this
    require('mini.icons').setup {} -- config this
    require('mini.pairs').setup {} -- config this
    require('mini.files').setup {} -- config this
    require('mini.git').setup {} -- config this
    require('mini.extra').setup {} -- config this
    require('mini.snippets').setup {} -- config this
    require('mini.clue').setup {} -- config this

    -- require('mini.hues').setup {}
    -- require('mini.colors').setup {}
    -- require('mini.bracketed').setup {}
    -- require('mini.bufremove').setup {}
    -- require('mini.completion').setup {}
    -- require('mini.cursorword').setup {}
    -- require('mini.deps').setup {}
    -- require('mini.docs').setup {}
    -- require('mini.fuzzy').setup {}
    -- require('mini.hipatterns').setup {}
    -- require('mini.indentscope').setup {}
    -- require('mini.jump').setup {}
    -- require('mini.jump2d').setup {}
    -- require('mini.keymap').setup {}
    -- require('mini.map').setup {}
    -- require('mini.misc').setup {}
    -- require('mini.move').setup {}
    -- require('mini.notify').setup {}
    -- require('mini.operators').setup {}
    -- require('mini.sessions').setup {}
    -- require('mini.splitjoin').setup {}
    -- require('mini.starter').setup {}
    -- require('mini.test').setup {}
    -- require('mini.tabline').setup {}
    -- require('mini.trailspace').setup {}
    -- require('mini.visits').setup {}
    -- require('mini.basics').setup {}
    -- require('mini.base16').setup {}

    -- set up creates a global table _G.MiniSurround (or other)
    -- config is stored in _G.MiniSurround.config
    -- can change fields on the fly
    -- MiniSurround.config.n_lines (can be changed @ runtime)
    -- also use buffer specific mini.nvim-buffer-local-config
    -- module-reulated buffers are named mini<module-name>://<buffer-number>/<useful-info> (may be empty)
    -- see disabling recipes to turn off for buffers
    -- config.silent = true (non-error feedback)
    -- canbecontrolled with ":h highlight-groups", ":highlight" or "vim.api.nvim_set_hl()"

    require 'plugins.mini_plugs.pick' -- config this
  end,
}
