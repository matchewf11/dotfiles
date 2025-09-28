vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = true

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'nosplit'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.o.guicursor = 'a:block'

vim.o.laststatus = 3

function _G.statusline()
  local lsp_get_clients = vim.lsp.get_clients
  local diag_get = vim.diagnostic.get
  local severity = vim.diagnostic.severity
  local client_names = {}
  for _, client in ipairs(lsp_get_clients { bufnr = 0 }) do
    client_names[#client_names + 1] = client.name
  end
  local clients_str = #client_names > 0 and table.concat(client_names, ', ') or ''
  local counts = { 0, 0, 0, 0 }
  for _, d in ipairs(diag_get(0)) do
    counts[d.severity] = counts[d.severity] + 1
  end
  local diag_parts = {}
  if counts[severity.ERROR] > 0 then
    diag_parts[#diag_parts + 1] = 'E:' .. counts[severity.ERROR]
  end
  if counts[severity.WARN] > 0 then
    diag_parts[#diag_parts + 1] = 'W:' .. counts[severity.WARN]
  end
  if counts[severity.INFO] > 0 then
    diag_parts[#diag_parts + 1] = 'I:' .. counts[severity.INFO]
  end
  if counts[severity.HINT] > 0 then
    diag_parts[#diag_parts + 1] = 'H:' .. counts[severity.HINT]
  end
  local diag_str = #diag_parts > 0 and table.concat(diag_parts, ' ') or ''
  local sep = ' | '
  local parts = {
    '%t',
    '[%M%R%H%W%Y]%q',
  }
  if vim.b.gitsigns_head and vim.b.gitsigns_head ~= '' then
    local git_section = vim.b.gitsigns_head
    if vim.b.gitsigns_status and vim.b.gitsigns_status ~= '' then
      git_section = git_section .. ' ' .. vim.b.gitsigns_status
    end
    parts[#parts + 1] = git_section
  elseif vim.b.gitsigns_status and vim.b.gitsigns_status ~= '' then
    parts[#parts + 1] = vim.b.gitsigns_status
  end
  parts[#parts + 1] = '%=' -- right side starts here
  if diag_str ~= '' then
    parts[#parts + 1] = diag_str
  end
  if clients_str ~= '' then
    parts[#parts + 1] = clients_str
  end
  parts[#parts + 1] = '%l/%L:%c'
  return ' ' .. table.concat(parts, sep) .. ' '
end

vim.o.statusline = '%!v:lua.statusline()'
