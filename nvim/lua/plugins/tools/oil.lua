return {
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
}
