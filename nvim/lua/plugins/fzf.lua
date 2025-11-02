return { -- config this
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  keys = {
    {
      '<leader>sf',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Search Files',
    },
    {
      '<leader>sb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Search Lines',
    },
    {
      '<leader>sl',
      function()
        require('fzf-lua').lines()
      end,
      desc = 'Search Lines',
    },
  },
}
