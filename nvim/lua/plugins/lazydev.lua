return { -- sets up lua lsp for nvim stuff and libraries
  'folke/lazydev.nvim',
  lazy = true,
  ft = 'lua',
  opts = {
    library = { -- do i use vim.uv?
      -- can add other libraries
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } }, -- maybe remove if not vim.uv
      'lazy.nvim',
    },
    -- enabled = true?
  },
}
