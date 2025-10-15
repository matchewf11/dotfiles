return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 0,
    spec = {
      { '<leader>s', group = '[s]earch' },
      { '<leader>g', group = '[g]it' },
    },
  },
}
