require('lazy').setup {
  spec = { { import = 'plugins' } },
  change_detection = { notify = false },
  install = { colorscheme = { 'vague' } },
  checker = { enabled = true, frequency = 604800 },
}
