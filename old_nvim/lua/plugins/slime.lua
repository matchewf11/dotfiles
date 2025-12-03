return {
  'jpalardy/vim-slime',
  ft = { 'haskell' },
  init = function()
    vim.g.slime_target = 'neovim'
    vim.g.slime_no_mappings = 1
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*',
      callback = function()
        vim.b.slime_config = { jobid = vim.b.terminal_job_id }
      end,
    })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'haskell',
      callback = function()
        vim.keymap.set('v', '<leader>r', '<Plug>SlimeRegionSend', {
          desc = 'Send selection to REPL',
          buffer = true,
        })
        vim.keymap.set('n', '<leader>r', '<Plug>SlimeParagraphSend', {
          desc = 'Send paragraph to REPL',
          buffer = true,
        })
      end,
    })
  end,
}
