return { -- config this
  'stevearc/oil.nvim',
  lazy = false,
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
  keys = {
    {
      '<leader>e',
      function()
        require('oil').open()
      end,
      desc = 'Open Oil',
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
