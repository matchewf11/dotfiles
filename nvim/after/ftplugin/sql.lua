vim.keymap.set('n', '<localleader>d', ':%DB $DATABASE_URL<CR>', {
  desc = 'Execute Entire File',
})

vim.keymap.set('v', '<localleader>d', ':DB $DATABASE_URL<CR>', {
  desc = 'Execute Highlighted Area',
})

vim.keymap.set('n', '<localleader>D', ':DB $DATABASE_URL ', {
  desc = 'Run DB Query',
})
