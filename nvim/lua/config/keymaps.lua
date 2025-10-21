local function set_maps(map_tbl)
  for _, val in ipairs(map_tbl) do
    vim.keymap.set(val[4] or 'n', val[1], val[2], { desc = val[3] })
  end
end

local M = {}

function M.global()
  set_maps {
    { '<Esc>', '<cmd>nohlsearch<CR>', 'Clear Highlights' },
    { '<C-h>', '<C-w><C-h>', 'Move focus to the left window' },
    { '<C-l>', '<C-w><C-l>', 'Move focus to the right window' },
    { '<C-j>', '<C-w><C-j>', 'Move focus to the lower window' },
    { '<C-k>', '<C-w><C-k>', 'Move focus to the upper window' },
    { '<C-S-h>', '<C-w>H', 'Move window to the left' },
    { '<C-S-l>', '<C-w>L', 'Move window to the right' },
    { '<C-S-j>', '<C-w>J', 'Move window to the lower' },
    { '<C-S-k>', '<C-w>K', 'Move window to the upper' },
    { '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode', 't' },
    { '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list' },
  }
end

function M.lsp()
  set_maps {
    { 'grn', vim.lsp.buf.rename, 're[n]ame' },
    { 'gra', vim.lsp.buf.code_action, 'code [a]ction', { 'n', 'x' } },
    { 'gri', vim.lsp.buf.implementation, '[i]mplementation' },
    { 'grr', vim.lsp.buf.references, '[r]efrences' },
    { 'grt', vim.lsp.buf.type_definition, '[t]ype definition' },
    { 'grD', vim.lsp.buf.declaration, '[D]eclaration' },
    { 'grd', vim.lsp.buf.definition, '[d]efinitions' },
    { 'gO', vim.lsp.buf.document_symbol, 'doc symbol' },
  }
end

return M
