return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = { globalstatus = true },
      sections = {
        lualine_a = {
          { 'mode' },
        },
        lualine_b = {
          { 'branch' },
          { 'diagnostics' },
          { 'diff' },
        },
        lualine_c = {
          { 'filename' },
        },
        lualine_x = {
          {
            'buffers',
            mode = 2,
          },
        },
        lualine_y = {
          { 'lsp_status' },
        },
        lualine_z = {
          { 'location' },
        },
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}

-- i am at comopnent specific options rn
--
