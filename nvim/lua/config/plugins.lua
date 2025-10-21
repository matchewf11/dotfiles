require('lazy').setup {
  spec = { { import = 'plugins' } },
  install = { colorscheme = { 'kanagawa-dragon' } },
  change_detection = { notify = false },
  checker = { enabled = true, frequency = 604800 },
}
