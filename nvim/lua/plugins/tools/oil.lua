-- all done!! I think i finished this
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
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
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
