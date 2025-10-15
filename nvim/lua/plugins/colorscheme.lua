return {
  'rebelot/kanagawa.nvim',
  name = 'kanagawa',
  priority = 1000,
  config = function()
    require('kanagawa').setup {
      commentStyle = { italic = false },
    }
    vim.cmd 'colorscheme kanagawa-dragon'
  end,
}
