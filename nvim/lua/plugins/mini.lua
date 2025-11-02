-- finish this

return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      require 'plugins.mini_plugs.pick' -- config this
      require('mini.statusline').setup {} -- config this
      require('mini.icons').setup {} -- config this
      require('mini.pairs').setup {} -- config this
      require('mini.snippets').setup {
        -- add stuff for eachlang
        -- config this
      }

      -- require('mini.hues').setup { -- config this more
      --   background = '#0f0f0e',
      --   foreground = '#e5dbce',
      --   n_hues = 8,
      --   saturation = 'medium',
      --   accent = 'fg',
      -- }

      -- require('mini.ai').setup {} -- config this
      -- require('mini.diff').setup {} -- config this
      -- require('mini.surround').setup {} -- config this
      -- require('mini.comment').setup {} -- config this
      -- require('mini.align').setup {} -- config this
      -- require('mini.git').setup {} -- config this
      -- require('mini.extra').setup {} -- config this
      -- require('mini.clue').setup {} -- config this
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
  },
  {
    'vague-theme/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'vague'
    end,
  },
  { -- config this
    'stevearc/oil.nvim',
    opts = {
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == '..'
        end,
      },
    },
    dependencies = { 'nvim-mini/mini.nvim' },
  },
}
