require('lazy').setup {
  spec = { { import = 'plugins' } },
  change_detection = { notify = false },
  checker = { enabled = true, frequency = 604800 },
}
