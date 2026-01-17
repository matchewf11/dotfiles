vim.keymap.set('n', '<localleader>r', '<CMD>!cargo run<CR>', { desc = 'Cargo Run' })
vim.keymap.set('n', '<localleader>c', '<CMD>!cargo check<CR>', { desc = 'Cargo Check' })
vim.keymap.set('n', '<localleader>t', '<CMD>!cargo test<CR>', { desc = 'Cargo Test' })
