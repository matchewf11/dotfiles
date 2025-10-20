return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require 'plugins.mini_plugs.pick'

    require('mini.surround').setup {}
    require('mini.comment').setup {}
    require('mini.align').setup {}
    require('mini.ai').setup {}
    require('mini.statusline').setup {}
    require('mini.icons').setup {}
    require('mini.pairs').setup {}
    require('mini.files').setup {}
    require('mini.diff').setup {}
    require('mini.git').setup {}
    require('mini.extra').setup {}
    require('mini.snippets').setup {}
    require('mini.clue').setup {}
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
  end,
  -- set up creates a global table _G.MiniSurround (or other)
  -- config is stored in _G.MiniSurround.config
  -- can change fields on the fly
  -- MiniSurround.config.n_lines (can be changed @ runtime)
  -- also use buffer specific mini.nvim-buffer-local-config
  -- module-reulated buffers are named mini<module-name>://<buffer-number>/<useful-info> (may be empty)
  -- see disabling recipes to turn off for buffers
  -- config.silent = true (non-error feedback)
  -- canbecontrolled with ":h highlight-groups", ":highlight" or "vim.api.nvim_set_hl()"
}
